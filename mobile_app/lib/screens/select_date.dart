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
          IconButton(
            icon: Icon(
              Icons.save_alt,
            ),
            onPressed: () {},
          )
        ],
        title: Text(
          "Add Sleep Session",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            color: Color(0xFF382E21),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // title: Text(
        //   "Add Sleep Session",
        //   style: TextStyle(
        //     fontFamily: 'Comfortaa', color: Color(0xFF382E21),fontSize: 20.0, fontWeight: FontWeight.bold,
        //   ),
        // ),
        // leading: IconButton(icon: Icon(Icons.arrow_back, color: Color(0xFF382E21), size: 30.0,),
        // onPressed: () => Navigator.pop(context,false),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFE0A7),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SelectDate()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {},
              ),
              //     ]),
              // Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
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
        // ]),
        shape: CircularNotchedRectangle(),
        color: Color(0xFFE08E79),
      ),
    );
  }
}
