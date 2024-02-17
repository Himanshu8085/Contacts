import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Create a function to create a database with a specific name
Future<Database> createDatabase(String dbName) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, '$dbName.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE your_table (
          id INTEGER PRIMARY KEY,
          usr_prefix TEXT,
          usr_first_name TEXT,
          usr_middle_name TEXT,
          usr_last_name TEXT,
          usr_country_code TEXT,
          usr_mobile_number TEXT,
          usr_email TEXT,
          usr_gender TEXT,
          usr_date_of_birth TEXT,
          Prefix TEXT,
          first_name TEXT,
          Middle_name TEXT,
          Last_name TEXT,
          Mobile_number TEXT,
          Email_ID TEXT,
          Date_of_birth TEXT,
          Gender TEXT,
          Address TEXT
        )
      ''');
    },
  );
}

// Create a function to insert data into a specific database
Future<void> insertData(Database database, Map<String, dynamic> data) async {
  await database.insert('your_table', data,
      conflictAlgorithm: ConflictAlgorithm.replace);
}
