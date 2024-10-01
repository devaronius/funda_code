import 'package:funda/features/lots/data/dto/funda_house_features_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'funda_house_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FundaHouseDto {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'images', defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'features')
  final FundaHouseFeaturesDto fundaFeatures;

  const FundaHouseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.fundaFeatures,
    required this.images,
  });

  factory FundaHouseDto.fromJson(Map<String, dynamic> json) {
    return _$FundaHouseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FundaHouseDtoToJson(this);
}
