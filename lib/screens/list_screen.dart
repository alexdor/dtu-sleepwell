import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/components/platform_item.dart';
import 'package:sleep_well/components/platform_scaffold.dart';
import 'package:sleep_well/components/platform_switch.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
