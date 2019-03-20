import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/components/platform_item.dart';
import 'package:sleep_well/components/platform_scaffold.dart';
import 'package:sleep_well/components/platform_switch.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _switch = new List.filled(20, false);

  @override
  Widget build(BuildContext context) {
    return new PlatformScaffold(
        title: "Here we go!",
        child: new ListView.builder(
            itemCount: _switch.length,
            itemBuilder: (context, index) => new ItemWidget(
                    child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 120.0),
                  child: new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Align(
                      alignment: const Alignment(-1.0, -1.0),
                      child: new Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            // _imageWidget('/assets/images/dummy.jpg'),
                            _spacerWidget,
                            _titleAndDescriptionWidget(
                                'This is a title', index + 1),
                            _spacerWidget,
                            _switchWidget(index),
                          ]),
                    ),
                  ),
                ))));
  }

  Widget _imageWidget(imageAsset) => new Image.asset(imageAsset);

  final _spacerWidget = new ConstrainedBox(
    constraints: const BoxConstraints.tightFor(width: 10.0),
  );

  Widget _titleAndDescriptionWidget(title, index) => new Flexible(
      flex: 4,
      fit: FlexFit.loose,
      child: new Align(
          alignment: const Alignment(-1.0, -1.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                "$title $index ",
                style: Theme.of(context).textTheme.display1,
              ),
              new Text(
                "This is a desc",
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          )));

  Widget _switchWidget(index) => new Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: new PlatformSwitch(
          onChanged: (value) => setState(() => _switch[index] = value),
          value: _switch[index],
        ),
      );
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
