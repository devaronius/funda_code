// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funda_house_features_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundaHouseFeaturesDto _$FundaHouseFeaturesDtoFromJson(
        Map<String, dynamic> json) =>
    FundaHouseFeaturesDto(
      askingPrice: (json['askingPrice'] as num).toDouble(),
      pricePerSquareMeter: (json['pricePerSquareMeter'] as num).toDouble(),
      status: json['status'] as String,
      acceptance: json['acceptance'] as String,
    );

Map<String, dynamic> _$FundaHouseFeaturesDtoToJson(
        FundaHouseFeaturesDto instance) =>
    <String, dynamic>{
      'askingPrice': instance.askingPrice,
      'pricePerSquareMeter': instance.pricePerSquareMeter,
      'status': instance.status,
      'acceptance': instance.acceptance,
    };
