part of 'lot_detail_bloc.dart';

sealed class LotDetailEvent extends Equatable {
  const LotDetailEvent();

  @override
  List<Object> get props => [];
}

final class InitLotDetailEvent extends LotDetailEvent {
  final String lotId;

  const InitLotDetailEvent({required this.lotId});
}

final class _RetryFetchingDataEvent extends LotDetailEvent {
  final String lotId;

  const _RetryFetchingDataEvent({required this.lotId});
}
