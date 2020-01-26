import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/datamodels.dart';
import '../utils/storage.dart';

class ReadFileScreen extends StatefulWidget {
  ReadFileScreen({Key key, this.title}) : super(key: key);
  
  final String title;
  final Storage storage = Storage();

  @override
  _ReadFileScreenState createState() => _ReadFileScreenState();

}

class _ReadFileScreenState extends State<ReadFileScreen> {

  Weapon _weapon;
  String _test = '{"title":"Some weapon","description":"Lorem ipsum pew pew","weight":200,"range":"30m","rateOfFire":"1/-/-","reloadSpeed":"2Full","type":"","damage":"1d10+10"}';

  void _readFile() async {
    String json = await widget.storage.readFile();
    Map weaponMap = jsonDecode(json);
    var weapon = Weapon.fromJson(weaponMap);
    setState(() {
      _weapon = weapon;

    });
  }

  void _writeFile() async {
    widget.storage.writeFile(_test);
  }

  void _clearFile() {
    widget.storage.clearFile();
    setState(() {
      _weapon = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Column(
        children: <Widget>[
          if (_weapon != null)
            Text(_weapon.title),
          RaisedButton(
            onPressed: _writeFile, //write object to file
            child: Text('Write')
          ),
          RaisedButton(
            onPressed: _readFile, //read object from file & display it
            child: Text('Read')
          ),
          RaisedButton(
            onPressed: _clearFile, //clear file
            child: Text('Clear')
          )
        ],
      )
    );
  }
}