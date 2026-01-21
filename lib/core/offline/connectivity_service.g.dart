// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityServiceHash() =>
    r'2b6578336a100a8841aa342bf5c6bfd5eb29fa36';

/// Connectivity Service
///
/// 네트워크 상태 변화를 감지하고 상태를 제공한다.
///
/// Copied from [ConnectivityService].
@ProviderFor(ConnectivityService)
final connectivityServiceProvider =
    AutoDisposeAsyncNotifierProvider<
      ConnectivityService,
      NetworkStatus
    >.internal(
      ConnectivityService.new,
      name: r'connectivityServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ConnectivityService = AutoDisposeAsyncNotifier<NetworkStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
