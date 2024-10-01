import 'package:json_annotation/json_annotation.dart';

part 'funda_house_features_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FundaHouseFeaturesDto {
  @JsonKey(name: 'askingPrice')
  final double askingPrice;
  @JsonKey(name: 'pricePerSquareMeter')
  final double pricePerSquareMeter;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'acceptance')
  final String acceptance;

  const FundaHouseFeaturesDto({
    required this.askingPrice,
    required this.pricePerSquareMeter,
    required this.status,
    required this.acceptance,
  });

  factory FundaHouseFeaturesDto.fromJson(Map<String, dynamic> json) {
    return _$FundaHouseFeaturesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FundaHouseFeaturesDtoToJson(this);
}
