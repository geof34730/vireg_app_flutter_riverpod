import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_class/localLang.dart';
import '../_class/localstore.dart';




class WidgetsEasySearchBar extends ConsumerWidget  implements PreferredSizeWidget {
  const WidgetsEasySearchBar({super.key});

  final bool errorSearchValue=false;
  final bool _choseListVers=false;
  final bool _persoListForm=false;


  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
   // const List<String> list = context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;
    var listlang = context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;
    print('list lang supported');
    print(listlang.runtimeType);

    /*******BEGIN Manage lang*********/
    Future.delayed(Duration(milliseconds: 20), () {
      late localstorelocal localstoreLang =localstorelocal(context: context, ref: ref);
      localstoreLang.updateLocalstore(lang: localstoreLang.getLangLoad());
    });
    /*******BEGIN Manage lang*********/

    return EasySearchBar(
        animationDuration: const Duration(milliseconds: 100),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        searchBackgroundColor: Colors.blue,
        searchHintText: context.loc.widgetsEasySearchBarLabelInputSearch,
        searchHintStyle: TextStyle(color: Colors.blue.withOpacity(0.8), fontWeight: FontWeight.bold),
        searchCursorColor: Colors.blue,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              iconEnabledColor: Colors.white,
              dropdownColor: Colors.blue,
              onChanged: (d){

                print(d);
              },


              items:L10n.all.map<DropdownMenuItem<Locale>>((value) {
                return DropdownMenuItem<Locale>(
                  value: value,
                  child: Text(value.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: (){
                   print("ddddd");
                  },
                );
              }).toList(),
            ),
          ),

        ],
        searchTextStyle: TextStyle(
          //ici color error
            color: (errorSearchValue ? Colors.red : Colors.black)),
        searchBackIconTheme: IconThemeData(
          color: (errorSearchValue ? Colors.red : Colors.blue),
        ),
        openOverlayOnSearch: false,

        title: Padding(
            padding: EdgeInsets.only(right: (_choseListVers || _persoListForm ? 34.0 : 12.0), left: (_choseListVers || _persoListForm ? 10.0 : 29.0)),
            child: Image.asset(
              'assets/images/logonav.png',
              fit: BoxFit.fitHeight,
            )),
        leading: Builder(
          builder: (BuildContext context) {
            return (_choseListVers || _persoListForm
                ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                //_onItemTapped(0);
                //  setState(() {
                //  _compteurInterstitial = 0;
                //_choseListVers = false;
                // _persoListForm = false;
                //  });
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            )
                : const SizedBox());
          },
        ),
        onSearch: (value) => {print('value')},
        asyncSuggestions: (value) async => await _fetchSuggestions(value));
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {

    return [];
  }






}