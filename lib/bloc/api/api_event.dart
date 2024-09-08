part of 'api_bloc.dart';

@freezed
class ApiEvent with _$ApiEvent {
  const factory ApiEvent.init() = InitEvent;
  const factory ApiEvent.upload({
    required int currentPage,
    String? searchText,
  }) = UploadEvent;
  const factory ApiEvent.search({required String text}) = SearchEvent;
}
