import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_wallet/providers/user_geo_location/user_geo_location_provider.dart';

part 'user_geo_location_event.dart';
part 'user_geo_location_state.dart';

class UserGeoLocationBloc
    extends Bloc<UserGeoLocationEvent, UserGeoLocationState> {
  UserGeoLocationBloc() : super(UserGeoLocationInitialState());

  @override
  Stream<UserGeoLocationState> mapEventToState(
    UserGeoLocationEvent event,
  ) async* {
    if (event is UserGeoLocationDeterminePosition) {
      try {
        final Position userPosition =
            await UserGeoLocationProvider().determineUserCurrentPosition();
        yield UserGeoLocationDetermined(userPosition: userPosition);
      } catch (e) {
        yield UserGeoLocationFailed();
      }
    } else if (event is UserGeoLocationDetermineCountry) {
      GeoCode geoCode = GeoCode();

      try {
        final Position userPosition =
            await UserGeoLocationProvider().determineUserCurrentPosition();

        var address = await geoCode.reverseGeocoding(
            latitude: userPosition.latitude, longitude: userPosition.longitude);
        yield UserCountryDetermined(address: address);
      } catch (e) {
        yield UserCountryDetermined(address: Address(countryName: "UAE"));
      }
    }
  }
}
