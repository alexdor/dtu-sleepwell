import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:sleep_well/helpers/enums.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text("Settings"),
        body: new SingleChildScrollView(
          child: Card(
            color: Color(0xFFF4E6D4),
            child: Column(
              children: [
                ListTile(
                  title: Text('See Intro', style: DefaultFontFamily),
                  leading: Icon(
                    Icons.info,
                    color: AppBlackColor,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/intro'),
                ),
                Divider(),
                ListTile(
                  title: Text('Account Settings (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.account_box,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Apple Health Kit (Under Development)',
                    style: DefaultFontFamily,
                  ),
                  leading: Icon(
                    Icons.healing,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Notifications (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.notifications,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Getting Started (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.help,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Support (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.contact_mail,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Terms & Conditions (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.label_important,
                    color: AppBlackColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Privacy Policy (Under Development)',
                      style: DefaultFontFamily),
                  leading: Icon(
                    Icons.data_usage,
                    color: AppBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
