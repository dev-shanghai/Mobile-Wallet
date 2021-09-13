// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// CountrySearchResponseModel _$CountrySearchResponseModelFromJson(
//         Map<String, dynamic> json) =>
//     CountrySearchResponseModel(
//       data: (json as List<dynamic>)
//           .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       //data: ((json as List<dynamic>).map((e))
//     );

Map<String, dynamic> _$CountrySearchResponseModelToJson(
        CountrySearchResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      countryName: json['name'] as String,
      countryCapital: json['capital'] as String,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'name': instance.countryName,
      'capital': instance.countryCapital,
    };
