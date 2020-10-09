import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imperial_sheets/components/misc/menuDrawer.dart';
import 'package:imperial_sheets/components/misc/tutorial.dart';
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
    'Stats',
    'Skills',
    'Talents',
    'Inventory',
    'Notes',
    'Powers',
  ];

  List<BottomNavigationBarItem> navigation() {
    return _destinations.map((destination) {
      return BottomNavigationBarItem(
          label: destination, icon: new Icon(Icons.adjust));
    }).toList();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    bool firstTime = !HiveProvider.of(context).settings.get('initialized', defaultValue: false);
    if (firstTime) {
      Future.delayed(Duration.zero,() {
        showDialog(context: context, builder: (context) => Tutorial());
      });
    }
    HiveProvider.of(context).initializeSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
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
        showUnselectedLabels: true,
        fixedColor: Theme.of(context).indicatorColor,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: navigation(),
      ),
    );
  }
}
