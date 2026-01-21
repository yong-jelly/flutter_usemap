import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'connectivity_service.g.dart';

/// 네트워크 연결 상태
enum NetworkStatus {
  online,
  offline,
}

/// Connectivity Service
/// 
/// 네트워크 상태 변화를 감지하고 상태를 제공한다.
@riverpod
class ConnectivityService extends _$ConnectivityService {
  Connectivity? _connectivity;
  Stream<NetworkStatus>? _statusStream;

  @override
  FutureOr<NetworkStatus> build() async {
    _connectivity = Connectivity();
    
    // 초기 상태 확인
    final result = await _connectivity!.checkConnectivity();
    final initialStatus = _mapConnectivityResult(result);
    
    // 상태 변화 스트림 생성
    _statusStream = _connectivity!.onConnectivityChanged
        .map((result) => _mapConnectivityResult(result));
    
    return initialStatus;
  }

  /// ConnectivityResult를 NetworkStatus로 변환
  NetworkStatus _mapConnectivityResult(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      return NetworkStatus.offline;
    }
    return NetworkStatus.online;
  }

  /// 현재 네트워크 상태 스트림
  Stream<NetworkStatus> get statusStream {
    return _statusStream ?? const Stream.empty();
  }
}
