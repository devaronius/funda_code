import 'package:funda/features/lots/domain/enums/house_status.dart';

class HouseFeaturesModel {
  final double askingPrice;

  final double pricePerSquareMeter;

  final HouseStatus status;

  final String acceptance;

  const HouseFeaturesModel({
    required this.askingPrice,
    required this.pricePerSquareMeter,
    required this.status,
    required this.acceptance,
  });
}
