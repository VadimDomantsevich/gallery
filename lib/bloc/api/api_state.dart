part of 'api_bloc.dart';

@freezed
class ApiState with _$ApiState {
  const factory ApiState.initial() = _Initial;
  const factory ApiState.loaded({
    required int currentPage,
    required Instruction response,
  }) = _Loaded;
}
