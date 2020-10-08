import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoButton extends StatelessWidget {

  Future<String> _getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    int _year = DateTime.now().year;
    return FutureBuilder(
      future: _getVersionNumber(),
      builder: (context, snapshot) {
        return AboutListTile(
          applicationVersion: snapshot.hasData ? snapshot.data : '',
          applicationLegalese: '© $_year SHeija',
          aboutBoxChildren: <Widget>[
            Padding(
              padding: EdgeInsets.only(left:8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Repository'),
                    subtitle: Text('Github'),
                    trailing: Icon(Icons.code),
                    onTap: () async {
                      await _launchURL('https://github.com/SHeija/imperial-sheets/');
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}