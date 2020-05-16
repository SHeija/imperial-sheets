import 'package:flutter/material.dart';

class NoCharacterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(),
        SliverPadding(
          padding: EdgeInsets.all(30),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text('No character selected'),
            ),
          ),
        )
      ],
    );
  }
}
