import 'package:dartz/dartz.dart';
import 'package:flutter_common/core/entities/place.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:rider_flutter/config/graphql/documents/geo.graphql.dart';

import '../error/failure.dart';
import 'geo_datasource.dart';
import 'graphql_datasource.dart';
import 'location_datasource.dart';

@prod
@LazySingleton(as: GeoDatasource)
class GeoDatasourceImpl implements GeoDatasource {
  final LocationDatasource locationDatasource;
  final GraphqlDatasource graphqlDatasource;

  GeoDatasourceImpl(this.graphqlDatasource, this.locationDatasource);

  @override
  Future<Either<Failure, PlaceEntity>> getAddressForLocation({required LatLng latLng}) async {
    final result = await graphqlDatasource.query(
      Options$Query$ReverseGeocode(
        variables: Variables$Query$ReverseGeocode(
          lat: latLng.latitude,
          lng: latLng.longitude,
        ),
      ),
    );
    return result.map((r) {
      final address = r.reverseGeocode;
      return PlaceEntity(
        coordinates: LatLngEntity(lat: address.point.lat, lng: address.point.lng),
        address: address.address,
      );
    });
  }

  @override
  Future<Either<Failure, PlaceEntity>> getCurrentLocation() async {
    final currentPosition = await locationDatasource.getCurrentLocation();
    return getAddressForLocation(latLng: currentPosition);
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlaces({required String query}) async {
    final queryResult =
        await graphqlDatasource.query(Options$Query$GetPlaces(variables: Variables$Query$GetPlaces(query: query)));
    return queryResult.map((r) {
      final places = r.getPlaces;
      return places
          .map(
            (e) => PlaceEntity(
              coordinates: LatLngEntity(lat: e.point.lat, lng: e.point.lng),
              address: e.address,
            ),
          )
          .toList();
    });
  }
}
