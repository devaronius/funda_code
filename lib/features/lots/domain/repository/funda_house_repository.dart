import 'package:dartz/dartz.dart';
import 'package:funda/core/failures/failures.dart';
import 'package:funda/features/lots/domain/models/house_details_model.dart';

interface class FundaHouseRepository {
  Future<Either<Failure, HouseDetailsModel>> fetchHouseById(String id) {
    throw UnimplementedError();
  }
}
