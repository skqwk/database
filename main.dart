class SemyonDB implements Database {
  Map<String, Table> tables = {};

  Map<String, Table> getTables() {
    return tables;
  }

  void addTable(String tableName) {
    if (tables[tableName] == null) {
      Table table = Table(tableName);
      tables[tableName] = table;
      return;
    }
    print("table $tableName already exists");
  }

  List<Row> readTable(String name) {
    Table table = tables[name];
    if (table == null) {
      return null;
    }
    return table.rows;
  }

  void removeTable(String tableName) {
    tables.remove(tableName);
  }

  void addRow(String tableName, Row row) {
    if (tables[tableName] == null) {
      return;
    }
    tables[tableName].rows.add(row);
  }

  Row readRow(String tableName, String rowId) {
    Table table = tables[tableName];
    if (table == null) {
      return null;
    }
    Row row = findRow(table, rowId);
    if (row == null) {
      return null;
    }
    return row;
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
  String name;
  List<Row> rows = [];
  Table(this.name);
}

class Row {
  String id;
  List<Field> fields;
  Row(this.id, this.fields);
}

class Field {
  String key;
  String value;
  Field(this.key, this.value);
}

class Database {
  Map<String, Table> getTables() {}

  void addTable(String tableName) {}

  List<Row> readTable(String name) {}

  void removeTable(String tableName) {}

  void addRow(String tableName, Row row) {}

  Row readRow(String tableName, String rowId) {}
}

void main() {
  Database db = SemyonDB();

  db.addTable("stories");
  var field1 = Field("name", "Supername");
  var field2 = Field("author", "Dima");
  var fields = [field1, field2];
  var story1 = Row("1", fields);
  db.addRow("stories", story1);

  // record

  // users
}
