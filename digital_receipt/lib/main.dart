import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(ThemeData.dark()),
          child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        final _theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(

        theme: _theme.getThemeData(),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _themeToggleFlag = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeChanger>(context);

  _changeTheme(){
        setState((){
          _themeToggleFlag = !_themeToggleFlag;
          });
          if(_themeToggleFlag){
        _theme.setThemeData(ThemeData.dark());
          }
          else{
        _theme.setThemeData(ThemeData.light());
          }

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: _themeToggleFlag ? Text('Dark mode') : Text('Light mode'),
              trailing: Switch(
                value: _themeToggleFlag, 
                onChanged: (_) => _changeTheme(),
            ),
            ),
        ],
        )
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
