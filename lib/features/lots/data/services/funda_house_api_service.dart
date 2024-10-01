import 'package:chopper/chopper.dart';
import 'package:funda/core/data/api/api_typedefs.dart';
import 'package:funda/features/lots/data/dto/funda_house_dto.dart';

part 'funda_house_api_service.chopper.dart';

@ChopperApi(baseUrl: 'feeds/Aanbod.svc/json/detail/')
abstract class FundaHouseApiService extends ChopperService {
  static FundaHouseApiService create([ChopperClient? client]) =>
      _$FundaHouseApiService();

  static Map<Type, JsonFactory> factoryConverters() => <Type, JsonFactory>{
        FundaHouseDto: FundaHouseDto.fromJson,
      };

  @Get(path: '{key}/koop/{id}')
  Future<Response<FundaHouseDto>> fetchHouseById({
    @Path('key') required String key,
    @Path('id') required String id,
  });
}
