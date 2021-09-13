import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_wallet/constants/app_colors.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';
import 'package:mobile_wallet/providers/register_user/models/country_search_response_model.dart';
import 'package:mobile_wallet/style/app_fonts.dart';

// ignore: must_be_immutable
class CountrySearchInput extends StatefulWidget {
  CountrySearchInput(
      {Key? key,
      required this.countriesList,
      this.selectedCountryName,
      required this.didChangeValue})
      : super(key: key);

  @override
  _CountrySearchInputState createState() => _CountrySearchInputState();

  String? selectedCountryName;
  List<CountryModel> countriesList;

  Function(String newValue) didChangeValue;
}

class _CountrySearchInputState extends State<CountrySearchInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserBloc, RegisterUserBlocState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
            ),
            const Text(
              "Country",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.darkBlack,
              ),
            ),
            // Container(
            //   height: 60,
            //   child:
            SizedBox(
              height: 60,
              child: DropdownSearch(
                // searchFieldProps: TextFieldProps(
                //     padding: EdgeInsets.only(top: 20, bottom: 10)),
                items: getCountryNames(widget.countriesList),
                //label: "Country",

                dropdownSearchDecoration: InputDecoration(
                  //errorText: widget.errorTitleText,

                  errorStyle: TextStyle(
                      fontSize: AppFonts.localeSize(context, 15),
                      color: AppColors.darkBlack,
                      fontWeight: FontWeight.w300,
                      fontFamily: AppFonts.localeFont(context)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkBlack, width: 2)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkBlack, width: 2)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkBlack, width: 2)),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkBlack, width: 2)),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkBlack, width: 2)),
                  hintText: "",
                ),
                hint: "",
                //mode: Mode.BOTTOM_SHEET,
                onChanged: (String? value) {
                  widget.selectedCountryName = value ?? "";
                  widget.didChangeValue(value ?? "");
                },
                selectedItem: getSelectedCountryName(widget.countriesList),
                validator: (String? item) {
                  if (item == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //)
          ],
        );
      },
    );
  }

  List<String> getCountryNames(List<CountryModel> countryList) {
    List<String> countryNames = [];
    for (CountryModel country in countryList) {
      countryNames.add(country.countryName);
    }

    return countryNames;
  }

  String getSelectedCountryName(List<CountryModel> countryList) {
    String countryName = "";
    for (CountryModel country in countryList) {
      if (country.countryName == widget.selectedCountryName) {
        countryName = country.countryName;
        break;
      }
    }

    return countryName;
  }
}
