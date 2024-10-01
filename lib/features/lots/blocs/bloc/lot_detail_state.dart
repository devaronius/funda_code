part of 'lot_detail_bloc.dart';

/// mixin to define all states that extends from this mixin as a error state
mixin LotDetailErrorState on LotDetailState {
  Failure get failure;
}

sealed class LotDetailState extends Equatable {
  const LotDetailState();
}

/// init state of teh detail page.
final class LotDetailInitialState extends LotDetailState {
  const LotDetailInitialState();

  @override
  List<Object?> get props => [];
}

/// In this state is the detail page fetching it's data
final class LotDetailInitialFetchingState extends LotDetailState {
  final String lotId;
  const LotDetailInitialFetchingState({required this.lotId});

  @override
  List<Object?> get props => [lotId];
}

/// temporary state to handle any failure messages
final class LotDetailInitialErrorState extends LotDetailState
    with LotDetailErrorState {
  @override
  final Failure failure;
  final String lotId;

  const LotDetailInitialErrorState({
    required this.failure,
    required this.lotId,
  });

  @override
  List<Object?> get props => [lotId, failure];
}

/// The data has been loaded and can be shown on screen.
final class LotDetailLoaded extends LotDetailState {
  final HouseDetailsModel model;

  const LotDetailLoaded({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}
