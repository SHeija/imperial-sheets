import 'package:flutter/material.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:imperial_sheets/views/inventoryView.dart';
import 'package:imperial_sheets/views/mainView.dart';
import 'package:imperial_sheets/views/skillView.dart';
import 'package:imperial_sheets/views/talentView.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../utils/generator.dart';

class RootView extends StatefulWidget {
  RootView({Key key}) : super(key:key);
  final Character _character = generateCharacter();
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _children = [
      MainView(),
      SkillView(),
      InventoryView(widget._character),
      TalentView(widget._character),
    ];

    final List<String> _destinations = [
      'Home',
      'Skills',
      'Inventory',
      'Talents',
    ];

    List<BottomNavigationBarItem> navigation() {
      return _destinations.map((destination) {
        return BottomNavigationBarItem(
            title: new Text(destination),
            icon: new Icon(Icons.adjust)
        );
      }).toList();
    }

    return ChangeNotifierProvider(
      create: (context) => CharacterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Imperial Sheets'),
        ),
        body: _children[_currentIndex], // body selected from a list of widgets
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex, // this will be set when a new tab is tapped
          onTap: onTabTapped,
          items: navigation(),
        ),
      ),
    );
  }
}