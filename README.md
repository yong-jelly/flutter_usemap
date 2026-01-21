# Demo Flutter App

Feature-First Clean Architecture + Riverpod 3.x를 사용한 Flutter 데모 앱입니다.

## 아키텍처

- **Feature-First**: 기능별로 폴더를 구성
- **Clean Architecture**: Domain/Data/Presentation 레이어 분리
- **Riverpod 3.x**: 상태 관리 (AsyncNotifier + codegen)
- **Supabase**: 백엔드 서비스

## 프로젝트 구조

```
lib/
├── app/              # 앱 초기화 및 설정
├── router/           # 라우팅 설정
├── core/             # 공통 기능
│   ├── di/          # 의존성 주입
│   ├── network/     # 네트워크 설정
│   ├── storage/     # 로컬 저장소
│   ├── offline/     # 오프라인 처리
│   ├── ui/          # 공통 UI
│   └── utils/       # 유틸리티
└── features/         # 기능별 모듈
    ├── onboarding/  # 온보딩 기능
    └── demo/        # 데모 기능 (리스트 + 폼)
```

## 주요 기능

1. **온보딩 화면**: 앱 첫 실행 시 표시되는 화면
2. **메인 화면**: 2개의 탭
   - 탭 1: 데이터 리스트 (Supabase에서 조회)
   - 탭 2: 폼/액션 (데이터 생성)

## 설정

### 1. Supabase 설정

`lib/app/bootstrap.dart`에서 Supabase URL과 Anon Key를 설정하세요:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### 2. Supabase 테이블 생성

Supabase 대시보드에서 다음 SQL을 실행하여 `demo_table`을 생성하세요:

```sql
CREATE TABLE demo_table (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS 정책 설정 (선택사항)
ALTER TABLE demo_table ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access" ON demo_table
  FOR SELECT USING (true);

CREATE POLICY "Allow public insert" ON demo_table
  FOR INSERT WITH CHECK (true);
```

### 3. 패키지 설치 및 코드 생성

```bash
# 패키지 설치
flutter pub get

# 코드 생성 (Riverpod, JSON, Drift 등)
flutter pub run build_runner build --delete-conflicting-outputs
```

## 실행

```bash
flutter run
```

## 코드 생성

이 프로젝트는 다음 코드 생성 도구를 사용합니다:

- `riverpod_generator`: Riverpod Provider 코드 생성
- `json_serializable`: JSON 직렬화 코드 생성
- `drift_dev`: Drift Database 코드 생성
- `freezed`: 불변 클래스 생성

코드를 수정한 후 다음 명령어로 코드를 재생성하세요:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

또는 watch 모드로 자동 생성:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 주요 패키지

- `flutter_riverpod`: 상태 관리
- `riverpod_annotation` + `riverpod_generator`: 코드 생성
- `supabase_flutter`: 백엔드 서비스
- `go_router`: 라우팅
- `drift`: 로컬 데이터베이스
- `connectivity_plus`: 네트워크 상태 감지
- `flutter_secure_storage`: 안전한 저장소

## 아키텍처 패턴

### Domain Layer
- 순수 Dart 클래스만 사용
- 외부 의존성 없음
- Entity, Repository 인터페이스, UseCase 정의

### Data Layer
- Supabase/Dio 등 외부 의존성 래핑
- Repository 인터페이스 구현
- DTO ↔ Entity 변환

### Presentation Layer
- Flutter UI 위젯
- Riverpod AsyncNotifier (Controller)
- UseCase를 통한 비즈니스 로직 호출

## 라이선스

이 프로젝트는 데모 목적으로 생성되었습니다.
