import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/misc/exportButton.dart';
import 'package:imperial_sheets/components/data/speedTable.dart';
import 'package:imperial_sheets/components/containers/aptitudeContainer.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import '../components/containers/infoContainer.dart';
import '../components/containers/statContainer.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character currentCharacter = HiveProvider.of(context).getActiveCharacter();
    bool autoExpOn = HiveProvider.of(context).settings.get('Auto exp calculation');
    if (autoExpOn) {
      currentCharacter.autoCalcExp();
    }
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          elevation: Theme.of(context).appBarTheme.elevation,
          forceElevated: true,
          actions: <Widget>[
            ExportButton(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      child: Column(
                        children: <Widget>[
                          Text('Really delete this character?'),
                          Text('This cannot be undone.')
                        ],
                      ),
                    );
                  },
                );
                if (result) {
                  HiveProvider.of(context).settings.put('activeCharacter', '');
                  currentCharacter.delete();
                }
              },
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverToBoxAdapter(
            child: InfoContainer(currentCharacter),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverToBoxAdapter(
            child: SpeedTable(
              character: currentCharacter,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Statistics'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: StatContainer(currentCharacter.stats),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Aptitudes'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverToBoxAdapter(
            child: AptitudeContainer(),
          ),
        )
      ],
    );
  }
}
