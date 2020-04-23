import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/speedTable.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../components/containers/infoContainer.dart';
import '../components/containers/statContainer.dart';

class MainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Imperial sheets'),
          floating: true,
          elevation: Theme.of(context).appBarTheme.elevation,
          forceElevated: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog();
                    }
                );
                if (result) {
                  Provider.of<CharacterModel>(context, listen: false).deleteCurrentCharacter();
                }
              },
            )
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: InfoContainer(Provider.of<CharacterModel>(context).getCharacter()),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: SliverToBoxAdapter(
            child: SpeedTable(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Statistics'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: StatContainer(Provider.of<CharacterModel>(context).getStats()),
        ),
      ],
    );
  }
}