import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/funda_assets.dart';
import '../../gen/l10n.dart';

class LotDetailLoadingOrganism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(FundaAssets.loadingImage),
          Text(
            Strings.of(context).lotFetchingData,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
