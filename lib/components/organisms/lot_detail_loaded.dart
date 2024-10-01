import 'package:flutter/material.dart';
import 'package:funda/components/atoms/gap.dart';
import 'package:funda/features/lots/domain/models/house_details_model.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../gen/l10n.dart';
import '../molecules/lot_image_carosel.dart';

class LotDetailLoadedOrganism extends StatelessWidget {
  final HouseDetailsModel model;

  const LotDetailLoadedOrganism(this.model);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();

    return CustomScrollView(
      slivers: [
        LotImageCarousel(model.images),
        const SliverGap(16),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: MultiSliver(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                formatCurrency.format(model.features.askingPrice),
              ),
              const Gap(16),
              Text(
                Strings.of(context).lotDescriptionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(8),
              Text(
                model.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SliverGap(16),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: MultiSliver(
            children: [
              Text(
                Strings.of(context).lotFeaturesTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        SliverList.list(
          children: [
            ListTile(
              leading:
                  Text(Strings.of(context).lotFeatureAskingPricePerSquareMeter),
              title: Text(
                formatCurrency.format(model.features.pricePerSquareMeter),
              ),
            ),
            ListTile(
              leading: Text(Strings.of(context).lotFeatureStatus),
              title: Text(model.features.status.valueKey),
            ),
            ListTile(
              leading: Text(Strings.of(context).lotFeatureAcceptance),
              title: Text(model.features.acceptance),
            ),
          ],
        ),
      ],
    );
  }
}
