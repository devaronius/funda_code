import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/components/organisms/lot_detail_loading.dart';
import 'package:funda/features/lots/blocs/bloc/lot_detail_bloc.dart';
import 'package:get_it/get_it.dart';

import '../organisms/lot_detail_loaded.dart';

class LotDetailTemplate extends StatelessWidget {
  final String id;
  const LotDetailTemplate({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LotDetailBloc>(
      create: (_) {
        return GetIt.instance<LotDetailBloc>()
          ..add(InitLotDetailEvent(lotId: id));
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocBuilder<LotDetailBloc, LotDetailState>(
              builder: (context, state) {
                return switch (state) {
                  LotDetailInitialState() ||
                  LotDetailInitialFetchingState() ||
                  LotDetailInitialErrorState() ||
                  LotDetailErrorState() =>
                    LotDetailLoadingOrganism(),
                  LotDetailLoaded(model: final model) =>
                    LotDetailLoadedOrganism(model),
                };
              },
            ),
          );
        },
      ),
    );
  }
}
