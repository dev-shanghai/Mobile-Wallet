import 'package:dio/dio.dart';
import 'package:mobile_wallet/constants/api_end_points.dart';
import 'package:mobile_wallet/providers/register_user/models/country_search_response_model.dart';

class RegisterUserProvider {
  Future<CountrySearchResponseModel> getCountriesList(String searchKey) async {
    CountrySearchResponseModel countrySearchResponseModel =
        CountrySearchResponseModel(data: []);

    try {
      String url = apiGetCountriesByName + searchKey + "?fields=name;capital";
      await Dio().get<dynamic>(url).then((Response<dynamic> response) {
        countrySearchResponseModel =
            CountrySearchResponseModel.fromJson(response.data);
      }).catchError((dynamic error) {
        // ignore: avoid_print
        print(error);
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    return countrySearchResponseModel;
  }

  Future<CountrySearchResponseModel> getAllCountriesList() async {
    CountrySearchResponseModel countrySearchResponseModel =
        CountrySearchResponseModel(data: []);

    try {
      String url = apiGetAllCountries + "?fields=name;capital";
      await Dio().get<dynamic>(url).then((Response<dynamic> response) {
        countrySearchResponseModel =
            CountrySearchResponseModel.fromJson(response.data);
      }).catchError((dynamic error) {
        // ignore: avoid_print
        print(error);
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    return countrySearchResponseModel;
  }
}
