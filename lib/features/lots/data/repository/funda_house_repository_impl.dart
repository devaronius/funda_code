import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:funda/core/failures/api_failures.dart';
import 'package:funda/core/failures/failures.dart';
import 'package:funda/features/lots/domain/models/house_details_model.dart';
import 'package:funda/features/lots/domain/parsers/house_parser.dart';
import 'package:funda/features/lots/domain/repository/funda_house_repository.dart';

import '../services/funda_house_api_service.dart';

class FundaHouseRepositoryImpl implements FundaHouseRepository {
  final FundaHouseApiService houseService;

  FundaHouseRepositoryImpl({required this.houseService});

  String get _key {
    return const String.fromEnvironment('KEY');
  }

  @override
  Future<Either<Failure, HouseDetailsModel>> fetchHouseById(String id) async {
    final result = await houseService.fetchHouseById(key: _key, id: id);
    if (!result.isSuccessful) {
      if (result.base.statusCode == HttpStatus.notFound) {
        return left(
          NotFoundFailure(stackTrace: StackTrace.current, response: result),
        );
      } else {
        result is Response<ApiFailure>
            ? result.body!
            : Failure(stackTrace: StackTrace.current);
      }
    }
    final body = result.body;
    if (body != null) {
      return Right(body.toModel());
    } else {
      return Left(
        Failure(stackTrace: StackTrace.current),
      );
    }
  }
}
