import 'package:json_annotation/json_annotation.dart';

part 'country_search_response_model.g.dart';

@JsonSerializable()
class CountrySearchResponseModel {
  ///empty constructor
  CountrySearchResponseModel({required this.data});

  factory CountrySearchResponseModel.fromJson(List<dynamic> json) =>
      CountrySearchResponseModel(
          data: json.map((e) => CountryModel.fromJson(e)).toList());
  Map<String, dynamic> toJson() => _$CountrySearchResponseModelToJson(this);

  /// country search response data
  List<CountryModel> data;
}

@JsonSerializable()
class CountryModel {
  CountryModel({required this.countryName, required this.countryCapital});

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @JsonKey(name: 'name')
  String countryName;

  @JsonKey(name: 'capital')
  String countryCapital;
}
