import 'package:funda/features/lots/domain/models/house_features_model.dart';

class HouseDetailsModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;

  final HouseFeaturesModel features;

  const HouseDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.features,
    required this.images,
  });
}
