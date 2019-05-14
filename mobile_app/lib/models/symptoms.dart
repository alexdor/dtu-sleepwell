import 'package:sleep_well/models/db.dart';
import 'package:sqflite/sqflite.dart';

class RecordingModel {
  int id;
  double rating;
  int headace;
  int freezing;
  int nightmares;
  int sweating;
  String notes;
  int duration;
  int date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'headace': headace,
      'freezing': freezing,
      'nightmares': nightmares,
      'sweating': sweating,
      'notes': notes,
      'duration': duration,
      'date': date
    };
  }

  RecordingModel(
      {this.id,
      this.rating,
      this.headace = 0,
      this.freezing = 0,
      this.nightmares = 0,
      this.sweating = 0,
      this.date,
      this.notes,
      this.duration});

  Future<void> create() async {
    final Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> res = await db.query('recordings',
        columns: ['id'], limit: 1, orderBy: 'id DESC');
    print(res);
    if (res.length > 0) {
      this.id = res[0]['id'] + 1;
    } else {
      this.id = 1;
    }
    await db.insert('recordings', this.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

RecordingModel _valuesToModel(Map<String, dynamic> map) {
  return RecordingModel(
    id: map['id'],
    rating: map['rating'],
    headace: map['headace'],
    freezing: map['freezing'],
    nightmares: map['nightmares'],
    sweating: map['sweating'],
    notes: map['notes'],
    duration: map['duration'],
    date: map['date'],
  );
}

Future<RecordingModel> lastSymptom() async {
  // Get a reference to the database
  final Database db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> maps =
      await db.query('recordings', orderBy: 'date DESC', limit: 1);

  if (maps.length > 0) {
    return _valuesToModel(maps[0]);
  }
  return null;
}

Future<List<RecordingModel>> symptoms() async {
  // Get a reference to the database
  final Database db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> maps =
      await db.query('recordings', orderBy: 'date DESC');

  if (maps.length > 0) {
    return List.generate(maps.length, (i) {
      return _valuesToModel(maps[i]);
    });
  }
  return null;
}

Future<List<RecordingModel>> symptomsBetween(int start, finish) async {
  // Get a reference to the database
  final Database db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> maps = await db.query('recordings',
      orderBy: 'date DESC', where: "date > $start AND date < $finish");

  if (maps.length > 0) {
    return List.generate(maps.length, (i) {
      return _valuesToModel(maps[i]);
    });
  }
  return null;
}
