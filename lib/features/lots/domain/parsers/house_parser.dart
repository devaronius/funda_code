import 'package:funda/features/lots/data/dto/funda_house_dto.dart';
import 'package:funda/features/lots/domain/enums/house_status.dart';
import 'package:funda/features/lots/domain/models/house_details_model.dart';
import 'package:funda/features/lots/domain/models/house_features_model.dart';

extension HouseParser on FundaHouseDto {
  HouseDetailsModel toModel() {
    return HouseDetailsModel(
      id: id,
      title: title,
      images: images,
      description: description,
      features: HouseFeaturesModel(
        askingPrice: fundaFeatures.askingPrice,
        pricePerSquareMeter: fundaFeatures.pricePerSquareMeter,
        status: HouseStatus.byKey(fundaFeatures.status),
        acceptance: fundaFeatures.acceptance,
      ),
    );
  }
}
