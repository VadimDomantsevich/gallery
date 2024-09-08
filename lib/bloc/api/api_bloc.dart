import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gallery_test/data/model/instruction_model.dart';
import 'package:gallery_test/data/services/api_service.dart';

part 'api_state.dart';
part 'api_event.dart';
part 'api_bloc.freezed.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService _apiService;
  ApiBloc(this._apiService) : super(const ApiState.initial()) {
    on<InitEvent>(_onInitEvent);
    on<UploadEvent>(_onUploadEvent);
    on<SearchEvent>(_onSearchEvent);
    // Init event on creating bloc
    add(const InitEvent());
  }

  Future<void> _onInitEvent(
    InitEvent event,
    Emitter<ApiState> emit,
  ) async {
    /// It's always first page on init
    int currentPage = 1;
    final response = await _apiService.getData(
      currentPage: currentPage,
    );
    state.mapOrNull(
      initial: (value) {
        emit(
          ApiState.loaded(response: response, currentPage: currentPage),
        );
      },
    );
  }

  /// Upload next page
  Future<void> _onUploadEvent(
    UploadEvent event,
    Emitter<ApiState> emit,
  ) async {
    final response = await _apiService.getData(
      searchText: event.searchText,
      currentPage: event.currentPage + 1,
    );
    state.mapOrNull(
      loaded: (value) {
        List<Hit> newHits = List.empty(growable: true);
        newHits.addAll(value.response.hits);
        newHits.addAll(response.hits);
        Instruction newInstrucrion = Instruction(
          total: value.response.total,
          totalHits: value.response.totalHits,
          hits: newHits,
        );
        newInstrucrion.hits.addAll(response.hits);
        emit(
          ApiState.loaded(
            currentPage: value.currentPage + 1,
            response: newInstrucrion,
          ),
        );
      },
    );
  }

  /// Search by text
  Future<void> _onSearchEvent(
    SearchEvent event,
    Emitter<ApiState> emit,
  ) async {
    /// It's always first page after search
    int currentPage = 1;
    final response = await _apiService.getData(
      searchText: event.text,
      currentPage: currentPage,
    );
    state.mapOrNull(
      loaded: (value) {
        emit(
          ApiState.loaded(
            currentPage: currentPage,
            response: response,
          ),
        );
      },
    );
  }
}
