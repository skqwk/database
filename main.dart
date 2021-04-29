import 'package:args/args.dart';
import 'dart:io';

class SemyonDB implements Database {
  //lock - to control streams
  Map<String, Table> _tables = {}; // private field
  final String _directory = "DB/";
  Map<String, Table> getTables() => Map.unmodifiable(_tables); // safely

  void addTable(String tableName) async {
    if (_tables[tableName] == null) {
      Table table = Table(tableName);
      var tableFile = await File(_directory + tableName + ".txt")
          .create(recursive: true); // create file for a table
      print(tableFile.path);
      _tables[tableName] = table;
      return;
    }
    throw "table $tableName already exists";
  }

  List<Row> readTable(String name) {
    Table table = _tables[name];
    if (table == null) {
      return null;
    }
    return List.unmodifiable(table.rows); // safely
  }

  bool removeTable(String tableName) {
    _tables.remove(tableName);
    return true;
  }

  void addRow(String tableName, Row row) async {
    if (_tables[tableName] == null) {
      return;
    }
    _tables[tableName].rows.add(row);
    File tableFile = File(_directory + tableName + ".txt"); // open file
    String _dataToFile = await tableFile
        .readAsString(); // read smthg that there existed // дописывать, а не перезаписывать
    print(_dataToFile);
    for (Field field in row.fields) {
      _dataToFile += field.value + " "; // add new row
    }
    print(_dataToFile);
    _dataToFile += "\n";
    tableFile.writeAsString(_dataToFile); // add fresh data
  }

  Row readRow(String tableName, String rowId) {
    Table table = _tables[tableName];
    if (table == null) {
      return null;
    }
    Row row = findRow(table, rowId);
    if (row == null) {
      return null;
    }
    return row; // safely, cause fields of class Row is private
  }

  Row findRow(Table table, String rowId) {
    for (Row row in table.rows) {
      if (row.id == rowId) {
        return row;
      }
    }
    return null;
  }
}

class Table {
  String _name;
  List<Row> _rows = [];

  String get name => _name;
  List<Row> get rows => _rows;
  Table(this._name);
}

class Row {
  String _id;
  List<Field> _fields;
  String get id => _id;
  List<Field> get fields => _fields;
  Row(this._id, this._fields);
}

class Field {
  String _key;
  String _value;
  String get key => _key;
  String get value => _value;
  Field(this._key, this._value);
}

abstract class Database {
  Map<String, Table> getTables();

  void addTable(String tableName);

  List<Row> readTable(String name);

  bool removeTable(String tableName);

  void addRow(String tableName, Row row);

  Row readRow(String tableName, String rowId);
}

Future<void> main() async {
  var parser = ArgParser();
  parser.addOption("name");

  print("Hello World");

  //initialization of common db
  Database db = SemyonDB(); // new DB

  await db.addTable("stories"); // DB -> add Table "Stories"
  var field1 = Field("name", "Supername");
  var field2 = Field("author", "Dima");
  // initialization field1, field2
  var fields1 = [field1, field2]; // group fields to list of fields

  var field3 = Field("name", "Supername");
  var field4 = Field("author", "Semyon");

  var fields2 = [field3, field4];

  print("adding row");
  var story1 = Row("1", fields1); // new Row == group of fields with name
  var story2 = Row("2", fields2);
  await db.addRow("stories", story1); // DB -> Table "Stories"-> add Row
  await db.addRow("stories", story2);

  // record

  // users
}
