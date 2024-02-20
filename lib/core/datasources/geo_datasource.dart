import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:rider_flutter/core/error/failure.dart';

abstract class GeoDatasource {
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlaces({required String query});
  Future<Either<Failure, PlaceEntity>> getAddressForLocation({required LatLng latLng});
  Future<Either<Failure, PlaceEntity>> getCurrentLocation();
}
