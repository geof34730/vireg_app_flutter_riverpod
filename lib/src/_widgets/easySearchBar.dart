import 'package:Vireg/src/_utils/string.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_class/Localstore.dart';

class WidgetsEasySearchBar extends ConsumerWidget implements PreferredSizeWidget {
  const WidgetsEasySearchBar({super.key});
  final bool errorSearchValue = false;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*******BEGIN Manage lang*********/
    var getlocalstorelocal = Localstorelocal(context: context, ref: ref);

      int numItemLangSelect = getlocalstorelocal.getItemLangSelect();
      var listLangSupported = getlocalstorelocal.listLangSupported();

    /*******END Manage lang*********/

    return EasySearchBar(
        callBackBackNav: () => {
          Navigator.pop(context)
        },
        animationDuration: const Duration(milliseconds: 100),
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
        leading:Builder(
            builder: (BuildContext context) {
              return SizedBox();
              },
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
                    capitalize(value.toString()),
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
        onSearch: (value) => {print('value')},
        asyncSuggestions: (value) async => await _fetchSuggestions(value));
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    return [];
  }
}
