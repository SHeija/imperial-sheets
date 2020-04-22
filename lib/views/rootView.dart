import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:imperial_sheets/views/inventoryView.dart';
import 'package:imperial_sheets/views/mainView.dart';
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
              title: Text(_characterList[index].name),
              subtitle: Text(_characterList[index].id.toString()),
            );
          },
          childCount: _characterList.length,
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
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: _getCharacterList(),
            )
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
    );
  }
}