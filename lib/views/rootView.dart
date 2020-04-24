import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/importButton.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:imperial_sheets/views/inventoryView.dart';
import 'package:imperial_sheets/views/mainView.dart';
import 'package:imperial_sheets/views/noCharacterView.dart';
import 'package:imperial_sheets/views/notesView.dart';
import 'package:imperial_sheets/views/powerView.dart';
import 'package:imperial_sheets/views/skillView.dart';
import 'package:imperial_sheets/views/talentView.dart';
import 'package:provider/provider.dart';

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
      TalentView(),
      InventoryView(),
      NotesView(),
      PowerView(),
    ];

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
            title: new Text(destination),
            icon: new Icon(Icons.adjust)
        );
      }).toList();
    }

    Widget _getCharacterList() {
      List<Character> _characterList = Provider.of<CharacterModel>(context).getAllCharacters();
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
            return ListTile(
              onTap: (){
                Provider.of<CharacterModel>(context, listen: false).setCurrentCharacter(_characterList[index]);
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.bookmark),
              title: Text(_characterList[index].name),
            );
          },
          childCount: _characterList.length,
        ),
      );
    }

    Widget _getDrawerActions() {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Divider(),
            ListTile(
              title: Text('Add new character'),
              leading: Icon(Icons.add),
              onTap: (){
                Provider.of<CharacterModel>(context, listen: false).createNewCharacter();
                Navigator.of(context).pop();
              },
            ),
            ImportButton(),
          ]
        ),
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
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: _getCharacterList(),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: _getDrawerActions(),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Provider.of<CharacterModel>(context).getCharacter() == null ? NoCharacterView() : _children[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: navigation(),
      ),
    );
  }
}