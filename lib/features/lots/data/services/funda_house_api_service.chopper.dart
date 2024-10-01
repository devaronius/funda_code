// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funda_house_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$FundaHouseApiService extends FundaHouseApiService {
  _$FundaHouseApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FundaHouseApiService;

  @override
  Future<Response<FundaHouseDto>> fetchHouseById({
    required String key,
    required String id,
  }) {
    final Uri $url =
        Uri.parse('feeds/Aanbod.svc/json/detail/${key}/koop/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FundaHouseDto, FundaHouseDto>($request);
  }
}
