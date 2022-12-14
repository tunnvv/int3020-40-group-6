import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool check = false;
  int slider_value = 10;
  List<bool> _isSelected = [false, true, false];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
              ),
            ),
            Checkbox(
              value: check,
              onChanged: (value) {
                setState(() {
                  check = value!;
                });
              },
            ),
            Slider(
              value: slider_value.toDouble(),
              min: 1.0,
              max: 100.0,
              divisions: 10,
              activeColor: Colors.green,
              inactiveColor: Colors.orange,
              label: slider_value.toString(),
              onChanged: (double newValue) {
                setState(() {
                  slider_value = newValue.round();
                });
              },
            ),
            ToggleButtons(
              children: <Widget>[
                Icon(Icons.highlight_rounded),
                Icon(Icons.bluetooth),
                Icon(Icons.wifi),
              ],
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  if (index == 0) {
                    _isSelected[0] = !_isSelected[0];
                    _isSelected[1] = false;
                    _isSelected[2] = false;
                  }
                  if (index == 1) {
                    _isSelected[1] = !_isSelected[1];
                    _isSelected[0] = false;
                    _isSelected[2] = false;
                  }
                  if (index == 2) {
                    _isSelected[2] = !_isSelected[2];
                    _isSelected[1] = false;
                    _isSelected[0] = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
