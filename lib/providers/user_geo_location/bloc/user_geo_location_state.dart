part of 'user_geo_location_bloc.dart';

abstract class UserGeoLocationState extends Equatable {
  const UserGeoLocationState();

  @override
  List<Object> get props => [];
}

class UserGeoLocationInitialState extends UserGeoLocationState {}

class UserGeoLocationDetermined extends UserGeoLocationState {
  const UserGeoLocationDetermined({required this.userPosition});

  @override
  List<Object> get props => [];

  final Position userPosition;
}

class UserCountryDetermined extends UserGeoLocationState {
  const UserCountryDetermined({required this.address});

  @override
  List<Object> get props => [];

  final Address address;
}

class UserGeoLocationFailed extends UserGeoLocationState {}
