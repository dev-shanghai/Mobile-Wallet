part of 'user_geo_location_bloc.dart';

abstract class UserGeoLocationEvent extends Equatable {
  const UserGeoLocationEvent();

  @override
  List<Object> get props => [];
}

class UserGeoLocationDeterminePosition extends UserGeoLocationEvent {
  const UserGeoLocationDeterminePosition();
}

class UserGeoLocationDetermineCountry extends UserGeoLocationEvent {
  const UserGeoLocationDetermineCountry();
}
