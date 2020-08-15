import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoView extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> _getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Repository'),
            subtitle: Text('Github'),
            leading: Icon(Icons.code),
            onTap: () async {
              await _launchURL('https://github.com/SHeija/imperial-sheets/');
            },
          ),
          ListTile(
            title: Text('License'),
            leading: Icon(Icons.gavel),
            subtitle: Text('MIT'),
            onTap: () async {
              print('Licence tapped');
              //await _launchURL('https://github.com/SHeija/imperial-sheets/blob/master/LICENSE.md')
            },
          ),
          FutureBuilder(
            future: _getVersionNumber(),
            builder: (context, snapshot) {
              return ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Version'),
                subtitle: snapshot.hasData ? Text(snapshot.data) : null,
              );
            },
          )
        ],
      ),
    );
  }
}
