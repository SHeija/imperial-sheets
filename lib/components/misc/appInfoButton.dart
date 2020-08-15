import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppInfoButton extends StatelessWidget {

  Future<String> _getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVersionNumber(),
      builder: (context, snapshot) {
        return ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Version'),
          subtitle: snapshot.hasData ? Text(snapshot.data) : null,
        );
      },
    );
  }
}