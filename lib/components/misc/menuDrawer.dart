import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'settingsButton.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/models/character.dart';

import 'importButton.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          SettingsButton(),
        ]),
      );
    }

    return Drawer(
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
    );
  }
}
