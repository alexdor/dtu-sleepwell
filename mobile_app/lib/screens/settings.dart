import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text("Settings"),
        body: new Container(
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Account Settings',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.account_box,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Apple Health Kit',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.healing,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Notifications'),
                  leading: Icon(
                    Icons.notifications,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Getting Started'),
                  leading: Icon(
                    Icons.help,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Support'),
                  leading: Icon(
                    Icons.contact_mail,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Terms & Conditions'),
                  leading: Icon(
                    Icons.label_important,
                    color: Color(0xFF382E21),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Privacy Policy'),
                  leading: Icon(
                    Icons.data_usage,
                    color: Color(0xFF382E21),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
