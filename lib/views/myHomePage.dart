import '../models/datamodels.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String text = 'This is a homepage';
  final List list = [
    Talent("Title1", "Desc1", 1, []),
    Talent("Talent2", "Desc2", 1, []),
    Talent("Talent3", "Desc3", 1, [])
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    return Scaffold(
      appBar: AppBar(
        // widget = myhomepage ylhäällä
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(

          child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                  title: Text(widget.list[index].title),
                  subtitle: Text(widget.list[index].description)
              );
            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
