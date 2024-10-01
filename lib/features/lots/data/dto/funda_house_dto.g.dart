// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funda_house_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundaHouseDto _$FundaHouseDtoFromJson(Map<String, dynamic> json) =>
    FundaHouseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fundaFeatures: FundaHouseFeaturesDto.fromJson(
          json['features'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$FundaHouseDtoToJson(FundaHouseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'features': instance.fundaFeatures.toJson(),
    };
