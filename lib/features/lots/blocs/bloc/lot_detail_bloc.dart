import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funda/core/di/funda_di.dart';
import 'package:funda/core/failures/failures.dart';
import 'package:funda/features/lots/domain/models/house_details_model.dart';
import 'package:funda/features/lots/domain/repository/funda_house_repository.dart';

part 'lot_detail_event.dart';
part 'lot_detail_state.dart';

class LotDetailBloc extends Bloc<LotDetailEvent, LotDetailState> {
  final FundaHouseRepository repository;

  LotDetailBloc({
    required this.repository,
  }) : super(const LotDetailInitialState()) {
    on<InitLotDetailEvent>((event, emit) {
      return switch (state) {
        LotDetailInitialState() => _initializeBloc(event.lotId, emit),
        LotDetailInitialFetchingState() ||
        LotDetailInitialErrorState() ||
        LotDetailLoaded() ||
        LotDetailErrorState() =>
          _handleNotAllowedEventCall(event, emit),
      };
    });
    // define how the event should be handled in the FSM
    // for the current state.
    on<_RetryFetchingDataEvent>((event, emit) {
      return switch (state) {
        LotDetailInitialState() ||
        LotDetailInitialFetchingState() ||
        LotDetailInitialErrorState() =>
          _initializeBloc(event.lotId, emit),
        LotDetailLoaded() ||
        LotDetailErrorState() =>
          _handleNotAllowedEventCall(event, emit),
      };
    });
  }

  @override
  void onTransition(Transition<LotDetailEvent, LotDetailState> transition) {
    final currentState = transition.currentState;
    onCurrentStateEnded(currentState);
    onNextStateStarted(currentState, transition.nextState);
    super.onTransition(transition);
  }

  void onCurrentStateEnded(LotDetailState current) {
    switch (current) {
      case LotDetailInitialFetchingState():
        FundaDi.logger.fine('Loading completed');
        break;
      case LotDetailInitialState() ||
            LotDetailLoaded() ||
            LotDetailErrorState():
        break;
    }
  }

  /// handle how the system should react when the next state is set as active.
  ///
  /// while this process is running we can alter it's logic
  /// on it's previous state.
  void onNextStateStarted(LotDetailState previous, LotDetailState next) {
    switch (next) {
      case LotDetailInitialFetchingState(lotId: final lotId):
        if (previous is LotDetailInitialErrorState) {
          FundaDi.logger.fine('Retry fetching data of lot: $lotId');
          return;
        }
        FundaDi.logger.fine('Loading lot with id number: $lotId');
        break;
      case LotDetailInitialErrorState(lotId: final lotId):
        // when we get into a intial error state
        // we wait for two seconds and try again.
        Future.delayed(
          const Duration(seconds: 2),
          () => add(_RetryFetchingDataEvent(lotId: lotId)),
        );
        break;
      case LotDetailLoaded():
      case LotDetailInitialState():
      case LotDetailErrorState():
        break;
    }
  }

  Future<void> _handleNotAllowedEventCall(
    LotDetailEvent event,
    Emitter<LotDetailState> emit,
  ) async {
    FundaDi.logger.severe(
      'event ${event.runtimeType} was called on '
      'state ${state.runtimeType}. This is not allowed',
    );
  }

  /// handle fetching the funda lot to show it on the screen.
  Future<void> _initializeBloc(
    String lotId,
    Emitter<LotDetailState> emitter,
  ) async {
    emitter(LotDetailInitialFetchingState(lotId: lotId));
    final result = await repository.fetchHouseById(lotId);
    result.fold((failure) {
      emitter(LotDetailInitialErrorState(failure: failure, lotId: lotId));
    }, (lotDetails) {
      emitter(LotDetailLoaded(model: lotDetails));
    });
  }
}
