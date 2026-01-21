생성일: 2026-01-21

# Google 로그인 및 프로필 시스템 설계서

본 문서는 Flutter 앱과 Supabase를 연동한 Google OAuth 인증 및 사용자 프로필 관리 시스템의 구조와 상세 구현 과정을 기술함.

---

## 1. 시스템 아키텍처 및 데이터 흐름

### 1.1 전체 구조도 (ASCII Flow)
```text
+-----------------------+       +-----------------------+       +-----------------------+
|      Flutter App      |       |     Supabase Auth     |       |     Google OAuth      |
+-----------------------+       +-----------------------+       +-----------------------+
| [Presentation Layer]  |       |                       |       |                       |
|  - AuthController     | ----> |  (1) signInWithIdToken| ----> | [Native Google UI]    |
|  - ProfileController  |       |                       |       |                       |
|                       | <---- |  (4) JWT Session      | <---- |  (2) ID Token (JWT)   |
| [Domain Layer]        |       |                       |       +-----------------------+
|  - UseCases           |       +-----------+-----------+
|  - Entities           |                   |
|                       |                   | (3) Sync User
| [Data Layer]          |                   v
|  - Repositories       |       +-----------+-----------+       +-----------------------+
|  - DataSources        |       |   PostgreSQL (DB)     |       |   Supabase Storage    |
+-----------+-----------+       +-----------------------+       +-----------------------+
            |                   | - tbl_user_profile    |       | - profile-avatars     |
            | (5) RPC Call      | - v1_get_user_profile |       |   bucket              |
            +-----------------> | - v2_upsert_user_p... | <---- |                       |
                                +-----------------------+       +-----------------------+
```

### 1.2 레이어별 구현 및 경로
- **Domain Layer**: 비즈니스 로직 및 엔티티 정의함.
  - `lib/features/auth/domain/entities/user_entity.dart`
  - `lib/features/auth/domain/entities/user_profile_entity.dart`
- **Data Layer**: 데이터 소스 및 모델 정의함.
  - `lib/features/auth/data/models/user_profile_model.dart`
  - `lib/features/auth/data/datasources/auth_remote_data_source.dart`
- **Presentation Layer**: UI 및 상태 관리 (Riverpod) 담당함.
  - `lib/features/auth/presentation/controllers/auth_controller.dart`
  - `lib/features/profile/presentation/controllers/profile_controller.dart`

---

## 2. 인증 시스템 연동 과정

### 2.1 Supabase 초기화 (`lib/app/bootstrap.dart`)
React 프로젝트와 동일한 프로젝트 환경을 사용하도록 설정함.
```dart
await Supabase.initialize(
  url: 'https://xyqpggpilgcdsawuvpzn.supabase.co',
  anonKey: 'sb_publishable_4rByGLkIJH0y9Qz7CKm1MA_ulfWQZtj',
);
```

### 2.2 Google Cloud Console (GCP) 및 iOS 설정
iOS 네이티브 SDK 동작을 위해 **iOS 전용 클라이언트 ID**를 생성하여 적용함.

**`ios/Runner/Info.plist` 적용 예시:**
- `GIDClientID`: GCP에서 발급받은 iOS용 일반 Client ID임.
- `CFBundleURLSchemes`: iOS용 ID의 Reversed Client ID임.
```xml
<key>GIDClientID</key>
<string>200658092432-3p16c1ecf0i4kl2b8ap73neti82l2v9o.apps.googleusercontent.com</string>
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.200658092432-3p16c1ecf0i4kl2b8ap73neti82l2v9o</string>
        </array>
    </dict>
</array>
```

### 2.3 Supabase Authorized Client IDs 설정
Supabase 대시보드 > Auth > Providers > Google 설정에서 **웹 ID와 iOS ID를 모두 등록**해야 `Unacceptable audience` 에러를 방지할 수 있음.
- 필드 값 예시:
  ```text
  739607551455-5j178o6ferb5eg31cah4iln18bs1tfdn.apps.googleusercontent.com
  200658092432-3p16c1ecf0i4kl2b8ap73neti82l2v9o.apps.googleusercontent.com
  ```
  *(두 ID 사이는 줄바꿈 또는 컴마로 구분함)*

---

## 3. 프로필 시스템 구현 상세

### 3.1 데이터 모델 및 엔티티
Freezed와 JsonSerializable을 사용하여 데이터 무결성 보장함.
```dart
// UserProfileModel (Data Layer)
@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    @JsonKey(name: 'auth_user_id') required String authUserId,
    required String nickname,
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    // ... createdAt, updatedAt 생략
  }) = _UserProfileModel;
}
```

### 3.2 프로필 업데이트 프로세스 (`v2_upsert_user_profile`)
사용자 프로필은 Supabase RPC를 통해 업데이트함.
1. `ProfileEditController`에서 유효성 검사 수행함.
2. `ProfileRepository`를 통해 RPC 함수 호출함.
3. 성공 시 `ProfileController`의 상태를 `refresh()`하여 UI 자동 갱신함.

### 3.3 이미지 업로드 및 처리
- **갤러리 업로드**: `image_picker` -> `StorageDataSource` -> Supabase Storage (`public-profile-avatars` 버킷).
- **랜덤 아바타**: DiceBear API 활용하여 SVG URL 생성 및 저장함.
- **이미지 렌더링**: `flutter_svg`와 `CachedNetworkImage`를 조합하여 SVG와 비트맵 이미지 모두 지원함.
```dart
// SVG 및 비트맵 분기 처리 예시
if (imageUrl.contains('/svg')) {
  return SvgPicture.network(imageUrl);
} else {
  return CachedNetworkImage(imageUrl: imageUrl);
}
```

---

## 4. Riverpod 기반 상태 관리 구조

### 4.1 의존성 흐름
```text
[UI: ProfileTab] 
    --> ref.watch(profileControllerProvider)
        --> [ProfileController] (AsyncNotifier)
            --> ref.watch(authControllerProvider) // 인증 상태 감시함
            --> getProfileUseCase // 프로필 데이터 로드함
```

### 4.2 컨트롤러 역할 분담
- **AuthController**: 현재 로그인된 사용자(`UserEntity`) 정보를 관리함.
- **ProfileController**: 로그인된 사용자의 상세 프로필(`UserProfileEntity`) 정보를 캐싱 및 관리함.
- **ProfileEditController**: 프로필 수정 중 발생하는 비동기 작업(이미지 업로드, RPC 호출)과 에러 상태를 담당함.

---

## 5. 트러블슈팅 (Troubleshooting) 이력

| 단계 | 발생 이슈 | 원인 | 해결 방안 |
| :--- | :--- | :--- | :--- |
| **초기화** | `invalid API key` (401) | 임시 `anonKey` 사용함. | React 실서버용 `sb_publishable_...` 키로 교체함. |
| **인증** | `NSInvalidArgumentException` | `GIDClientID` 키 누락됨. | `Info.plist`에 해당 키 강제 추가함. |
| **인증** | `Custom scheme URIs...` | iOS에 Web용 ID 사용함. | **iOS 전용 클라이언트 ID** 새로 생성하여 적용함. |
| **연동** | `Unacceptable audience` | Supabase 허용 목록 누락됨. | 대시보드 Authorized IDs에 iOS ID 추가함. |
| **UI** | `Invalid image data` | SVG 포맷 렌더링 불가함. | `flutter_svg` 패키지 도입 및 분기 처리함. |

---

## 6. 결론
본 시스템은 **Feature-First Clean Architecture**를 기반으로 설계되었으며, 리버팟을 통해 인증 상태와 프로필 데이터 간의 유기적인 연동을 구현함. 모든 보안 값은 GCP 및 Supabase의 정책에 맞춰 설정되었으며, 플랫폼별 네이티브 특성을 고려한 견고한 인증 플로우를 제공함.
