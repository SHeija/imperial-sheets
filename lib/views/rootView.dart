import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imperial_sheets/components/common/appInfoButton.dart';
import 'package:imperial_sheets/components/common/importButton.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/views/inventoryView.dart';
import 'package:imperial_sheets/views/mainView.dart';
import 'package:imperial_sheets/views/noCharacterView.dart';
import 'package:imperial_sheets/views/notesView.dart';
import 'package:imperial_sheets/views/powerView.dart';
import 'package:imperial_sheets/views/skillView.dart';
import 'package:imperial_sheets/views/talentView.dart';

class RootView extends StatefulWidget {
  RootView({Key key}) : super(key: key);
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
    Widget _getView() {
      final List<Widget> _children = [
        MainView(),
        SkillView(),
        TalentView(),
        InventoryView(),
        NotesView(),
        PowerView(),
      ];

      return _children[_currentIndex];
    }

    final List<String> _destinations = [
      'Home',
      'Skills',
      'Talents',
      'Inventory',
      'Notes',
      'Powers',
    ];

    List<BottomNavigationBarItem> navigation() {
      return _destinations.map((destination) {
        return BottomNavigationBarItem(
            title: new Text(destination), icon: new Icon(Icons.adjust));
      }).toList();
    }

    Widget _drawerCharacterListBuilder() {
      return ValueListenableBuilder(
        valueListenable: HiveProvider.of(context).characters.listenable(),
        builder: (context, box, widget) {
          List<Character> _characterList = box.values.toList();
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    HiveProvider.of(context)
                        .settings
                        .put('activeCharacter', _characterList[index].id);
                    print('Set active character ' + _characterList[index].id);
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.bookmark),
                  title: Text(_characterList[index].name),
                );
              },
              childCount: _characterList.length,
            ),
          );
        },
      );
    }

    Widget _drawerActionsBuilder() {
      return SliverList(
        delegate: SliverChildListDelegate([
          Divider(),
          ListTile(
            title: Text('Add new character'),
            leading: Icon(Icons.add),
            onTap: () {
              Character _newChar = Character.blank()
                ..id = DateTime.now().toIso8601String();
              HiveProvider.of(context).characters.put(_newChar.id, _newChar);
              HiveProvider.of(context)
                  .settings
                  .put('activeCharacter', _newChar.id);
              print('created character ' + _newChar.id);
              Navigator.of(context).pop();
            },
          ),
          ImportButton(),
          AppInfoButton(),
        ]),
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: DrawerHeader(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Imperial Sheets',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white)),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: _drawerCharacterListBuilder(),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: _drawerActionsBuilder(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: HiveProvider.of(context)
              .settings
              .listenable(keys: ['activeCharacter']),
          builder: (context, box, widget) {
            String id = box.get('activeCharacter');
            if (id == null || id == '') {
              return NoCharacterView();
            } else {
              return ValueListenableBuilder(
                  valueListenable:
                      HiveProvider.of(context).characters.listenable(),
                  builder: (context, box, widget) {
                    return _getView();
                  });
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: navigation(),
      ),
    );
  }
}
