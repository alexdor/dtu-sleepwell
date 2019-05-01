import 'package:flutter/material.dart';

class SelectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4E6D4),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFFE08E79),
        actions: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Save",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFF382E21),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Add Sleep Session",
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            color: Color(0xFF382E21),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFE0A7),
        onPressed: () {
          Navigator.pushNamed(context, '/date');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "Select Date",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFF382E21),
                  fontSize: 20.0,
                ),
              ),
              leading: Icon(
                Icons.calendar_today,
                color: Color(0xFF382E21),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(null),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.graphic_eq),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              )
            ]),
        shape: CircularNotchedRectangle(),
        color: Color(0xFFE08E79),
      ),
    );
  }
}