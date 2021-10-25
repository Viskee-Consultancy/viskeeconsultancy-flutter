import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:viskeeconsultancy/Widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Region.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/ConfigurationDownloadPage.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

class RegionSelectionPage extends StatelessWidget {
  RegionSelectionPage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonWidgets.getAppBar(context),
      body: Container(
          child: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
        Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.center,
              child: Text("Please choose your country",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
        ),
        ConstrainedBox(
            constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.GOLD),
                      borderRadius: const BorderRadius.all(const Radius.circular(8)),
                    ),
                    child: new CountrySelectionAutocomplete()))),
        Expanded(
            flex: 3,
            child: Container(
              child: null,
            )),
      ])),
    );
  }
}

class CountrySelectionAutocomplete extends StatelessWidget {
  List<String> countries = [];

  CountrySelectionAutocomplete() {
    countries.addAll(Region.SEAPAE);
    countries.addAll(Region.SISMIC);
  }

  final TextEditingController _typeAheadController = TextEditingController();

  List<String> _getCountrySuggestions(String query, List<String> countries, List<String> suggestions) {
    if (query == '') {
      return List.empty();
    }
    suggestions.clear();
    String searchText = query.toLowerCase();

    for (var country in countries) {
      if (country.toLowerCase().contains(searchText)) {
        suggestions.add(country);
      }
    }
    suggestions.sort();
    return suggestions;
  }

  void _itemSelected(String? selected, BuildContext context) {
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Please enter the search text'),
      ));
    } else {
      if (Region.SEAPAE.any((country) => country.toLowerCase() == selected)) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ConfigurationDownloadPage(SubFolderEnum.SEAPAE)));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ConfigurationDownloadPage(SubFolderEnum.SISMIC)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> suggestions = [];
    return TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        cursorColor: CustomColors.GOLD,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Type your country name",
            fillColor: CustomColors.GOLD),
        controller: this._typeAheadController,
      ),
      itemBuilder: (context, suggestion) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(suggestion!),
      ),
      suggestionsCallback: (query) => _getCountrySuggestions(query, countries, suggestions),
      onSuggestionSelected: (suggestion) => {_itemSelected(suggestion, context)},
    );
  }
}
