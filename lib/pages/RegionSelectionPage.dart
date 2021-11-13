import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Region.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/ConfigurationDownloadPage.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

class RegionSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, true);
          return true;
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CommonWidgets.getAppBar(context, true),
          body: Container(
              child: Column(children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, AppBar().preferredSize.height + 20, 5, 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Please choose your country",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
            )),
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
        ));
  }
}

class CountrySelectionAutocomplete extends StatelessWidget {
  final List<String> _countries = [];

  CountrySelectionAutocomplete() {
    _countries.addAll(Region.SEAPAE);
    _countries.addAll(Region.SISMIC);
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
      NavigationPath.PATH.add(selected);
      if (Region.SEAPAE.any((country) => country.toLowerCase() == selected.toLowerCase())) {
        Navigator.push(
            context,
            PageTransition(
                child: ConfigurationDownloadPage(SubFolderEnum.SEAPAE), type: PageTransitionType.rightToLeft));
      } else {
        Navigator.push(
            context,
            PageTransition(
                child: ConfigurationDownloadPage(SubFolderEnum.SISMIC), type: PageTransitionType.rightToLeft));
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
      suggestionsCallback: (query) => _getCountrySuggestions(query, _countries, suggestions),
      onSuggestionSelected: (suggestion) => {_itemSelected(suggestion, context)},
    );
  }
}
