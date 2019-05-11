import 'package:sleep_well/models/db.dart';
import 'package:sqflite/sqflite.dart';

class SettingsModel {
  final int id;
  final int showIntro;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'showIntro': showIntro,
    };
  }

  SettingsModel({this.id, this.showIntro});
}

Future<void> changeShowIntro(bool value) async {
  final Database db = await DatabaseHelper.instance.database;

  int _val = 0;
  if (value) {
    _val = 1;
  }

  await db.insert('settings', SettingsModel(id: 1, showIntro: _val).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<SettingsModel> settings() async {
  // Get a reference to the database
  final Database db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> maps = await db.query('settings', limit: 1);

  if (maps.length > 0) {
    return SettingsModel(id: maps[0]['id'], showIntro: maps[0]['showIntro']);
  }
  return SettingsModel(id: 1, showIntro: 1);
}
