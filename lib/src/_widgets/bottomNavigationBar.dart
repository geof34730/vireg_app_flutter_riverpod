import 'package:Vireg/src/_class/bottomNavigationBar.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class WidgetbottomNavigationBar extends ConsumerWidget {
  const WidgetbottomNavigationBar({super.key, required int this.indexNav});
  final int indexNav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late viregBottomNavigationBar objViregBottomNavigationBar = viregBottomNavigationBar(ref: ref,context: context,indexNav:indexNav);
    int _selectedIndex = objViregBottomNavigationBar.getItemSelect();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: context.loc.bottomNavigationBarLearn,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: context.loc.bottomNavigationBarTest,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.visibility),
          label: context.loc.bottomNavigationBarSeeTheList,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      iconSize: 50.00,
      onTap: (index){_onItemTapped(index: index, objViregBottomNavigationBar: objViregBottomNavigationBar);},
    );
  }
  void _onItemTapped({required int index, required viregBottomNavigationBar objViregBottomNavigationBar}) {
    objViregBottomNavigationBar.goItemNav(index:index);
  }

}