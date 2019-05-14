import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/enums.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget body;
  final bool hideAppBar;
  final Widget title;
  final List<Widget> actions;

  const ScreenScaffold(
      {Key key, this.body, this.hideAppBar, this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: hideAppBar != null && hideAppBar
          ? null
          : AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: SecondayBackgroundColor,
              actions: actions,
              title: title,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFE0A7),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/date',
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      body: body,
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.pushNamed(context, '/diary');
                },
              ),
              IconButton(
                icon: Icon(null),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/date',
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.graphic_eq),
                onPressed: () {
                  Navigator.pushNamed(context, '/monthdata');
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              )
            ]),
        shape: CircularNotchedRectangle(),
        color: SecondayBackgroundColor,
      ),
    );
  }
}
