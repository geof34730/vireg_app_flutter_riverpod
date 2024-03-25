import 'package:Vireg/src/_utils/string.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:Vireg/src/router.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/GetDataVerbs.dart';
import '../_providers/localLang.dart';
import '../_class/Localstore.dart';
import '../_utils/logger.dart';

class WidgetsEasySearchBar extends ConsumerStatefulWidget {
  WidgetsEasySearchBar({Key? key, required this.backButton}) : super(key: key);

  final String? backButton;

  @override
  _WidgetsEasySearchBarState createState() => _WidgetsEasySearchBarState();
}


class _WidgetsEasySearchBarState extends ConsumerState<WidgetsEasySearchBar> {
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  late List<String> _suggestions = [];
  late  bool errorSearchValue = false;
  @override
  void initState() {
    Logger.Red.log("init state Easy search bar");
    super.initState();
  }

  @override
  void dispose() {
    Logger.Red.log("dispose Easy search bar");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    /*******BEGIN Manage lang*********/
    var getlocalstorelocal = Localstorelocal(context: context, ref: ref);
      int numItemLangSelect = getlocalstorelocal.getItemLangSelect();
      var listLangSupported = getlocalstorelocal.listLangSupported();
    /*******END Manage lang*********/

    return EasySearchBar(
        canPop:(widget.backButton!=null),
        callBackBackNav: () => (widget.backButton!=null ? customRoutesVireg.go(widget.backButton!) : null),
        animationDuration: const Duration(milliseconds: 100),
        colorIconClose:(errorSearchValue ? Colors.red : Colors.grey),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        searchBackgroundColor: Colors.blue,
        searchHintText: context.loc.widgetsEasySearchBarLabelInputSearch,
        searchHintStyle: TextStyle(color: Colors.blue.withOpacity(0.8), fontWeight: FontWeight.bold),
        searchCursorColor: Colors.blue,
        searchTextStyle:TextStyle(color: (errorSearchValue ? Colors.red : Colors.black)),
        searchBackIconTheme: IconThemeData(color: (errorSearchValue ? Colors.red : Colors.blue),),
        openOverlayOnSearch: false,

        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logonav.png',
              fit: BoxFit.fitHeight,
            )
          ],
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: listLangSupported.elementAt(numItemLangSelect),
              iconEnabledColor: Colors.white,
              style: TextStyle(
                color: Colors.red,
              ),
              dropdownColor: Colors.blue,
              alignment: Alignment.topRight,
              onChanged: (langSelect) {
                Localstorelocal(context: context, ref: ref).updateLocalstoreLang(lang: langSelect.toString());
                    },
              items: listLangSupported.map<DropdownMenuItem<Locale>>((value) {
                return DropdownMenuItem<Locale>(
                  value: value,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: (value != listLangSupported.elementAt(numItemLangSelect) ? FontWeight.normal : FontWeight.bold),
                      // decoration: (value != listLangSupported.elementAt(numItemLangSelect) ? TextDecoration.none : TextDecoration.underline),
                     // backgroundColor: Colors.green
                    ),
                  ),
                  onTap: () {},
                );
              }).toList(),
            ),
          )
        ],
        onSearch: (itemStringNoClean)  {
          Logger.Red.log(itemStringNoClean);
          String idVerbSelect=itemStringNoClean.substring(itemStringNoClean.indexOf("|") + 1, itemStringNoClean.length);
          customRoutesVireg.go("/search/$idVerbSelect");

        },
        asyncSuggestions: (value) async => await _fetchSuggestions(value));
  }


  Future<List<String>> _fetchSuggestions(String searchValue) async {
  //  if (_suggestions.isEmpty) {
      await getSearchVerbs();
  //  }
    // await Future.delayed(const Duration(milliseconds: 250));
    List<String> suggestionsList = _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
    errorSearchValue = (suggestionsList.isEmpty);
    setState(() {});
    return suggestionsList;
  }

  Future<void> getSearchVerbs() async {
    List<dynamic> data = await GetDataVerbs().getDataJson(idList: "top200");
    List<String> verbs = [];
    int z = 0;
    for (var datas in data) {
      if (datas["infinitif"] != null) {
        verbs.add("${toTitleCase(datas["infinitif"])}|${datas["id"].toString()}");
      }
      if (datas["pastSimple"] != null) {
        verbs.add("${toTitleCase(datas["pastSimple"])}|${datas["id"].toString()}");
      }
      if (datas["pastParticipe"] != null) {
        verbs.add("${toTitleCase(datas["pastParticipe"])}|${datas["id"].toString()}");
      }
      if (datas[ref.watch(localLangProvider)] != null) {
        verbs.add("${toTitleCase(datas[ref.watch(localLangProvider)])}|${datas["id"].toString()}");
      }
      z++;
    }
    Logger.Magenta.log(verbs);

    verbs.sort((String a, String b) => a.compareTo(b));
    _suggestions = verbs;
  }

}
