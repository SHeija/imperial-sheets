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
      InventoryView(),
      TalentView(),
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
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
        ),
        body: SafeArea(
          child: _children[_currentIndex],
        ),
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