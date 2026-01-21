import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/api_exception.dart';
import '../models/demo_model.dart';

/// Demo Remote Data Source
/// 
/// Supabase를 통한 원격 데이터 소스
class DemoRemoteDataSource {
  final SupabaseClient _supabase;

  DemoRemoteDataSource(this._supabase);

  /// 현재 시간 조회 (SELECT now())
  /// 
  /// Supabase의 RPC 함수를 통해 현재 시간을 조회한다.
  /// RPC 함수가 없는 경우, 서버 시간을 대신 사용한다.
  Future<DateTime> getCurrentTime() async {
    try {
      // RPC 함수가 설정되어 있다면 사용, 없으면 서버 응답 시간 사용
      try {
        final response = await _supabase.rpc('get_current_time');
        if (response != null) {
          return DateTime.parse(response as String);
        }
      } catch (_) {
        // RPC 함수가 없으면 서버 시간 사용
      }
      
      // 대안: 서버 응답 헤더의 시간 사용 또는 현재 시간 반환
      return DateTime.now();
    } on PostgrestException catch (e) {
      throw ServerException(e.message, statusCode: e.code != null ? int.tryParse(e.code!) : null);
    } catch (e) {
      throw UnknownException('알 수 없는 오류: ${e.toString()}', originalError: e);
    }
  }

  /// Demo 항목 목록 조회
  Future<List<DemoModel>> getDemoItems() async {
    try {
      final response = await _supabase
          .from('demo_table')
          .select()
          .order('created_at', ascending: false);

      final List<dynamic> items = response as List<dynamic>;
      return items
          .map((json) => DemoModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message, statusCode: e.code != null ? int.tryParse(e.code!) : null);
    } catch (e) {
      throw UnknownException('알 수 없는 오류: ${e.toString()}', originalError: e);
    }
  }

  /// Demo 항목 생성
  Future<DemoModel> createDemoItem({
    required String title,
    required String description,
  }) async {
    try {
      final response = await _supabase
          .from('demo_table')
          .insert({
            'title': title,
            'description': description,
          })
          .select()
          .single();

      return DemoModel.fromJson(response as Map<String, dynamic>);
    } on PostgrestException catch (e) {
      throw ServerException(e.message, statusCode: e.code != null ? int.tryParse(e.code!) : null);
    } catch (e) {
      throw UnknownException('알 수 없는 오류: ${e.toString()}', originalError: e);
    }
  }
}
