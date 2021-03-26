class SemyonDB implements Database {
  List<Collection> collections = [];

  List<Collection> getCollections() {
    return collections;
  }

  void addCollection(String collectionName) {
    var collection = Collection(collectionName);
    collections.add(collection);
  }

  List<Row> readCollection(String name) {
    var collection = findCollection(name);
    if (collection != null) {
      return collection.rows;
    }
  }

  void removeCollection(String collectionName) {
    var collection = findCollection(collectionName);
  }

  void addRow(String collectionName, Row row) {
    var collection = findCollection(collectionName);
    if (collection != null) {
      collection.rows.add(row);
    }
  }

  Row readRow(String collectionName, String rowId) {
    var collection = findCollection(collectionName);
    ;
    if (collection != null) {
      var row = findRow(collection, rowId);
      if (row != null) {
        return row;
      }
    }
  }

  Row findRow(Collection collection, String rowId) {
    var row;
    for (row in collection.rows) {
      if (row.id == rowId) {
        return row;
      }
    }
  }

  Collection findCollection(String collectionName) {
    var collection;
    for (collection in collections) {
      if (collection.name == collectionName) {
        return collection;
      }
      return collection;
    }
  }
}

// Table
class Collection {
  String name;
  List<Row> rows;
  Collection(this.name);
}

class Row {
  String id;
  List<Cage> cages;
  Row(this.id, this.cages);
}

class Cage {
  String key;
  String value;
  Cage(this.key, this.value);
}

class Database {
  List<Collection> getCollections() {}

  void addCollection(String collectionName) {}

  List<Row> readCollection(String name) {}

  void removeCollection(String collectionName) {}

  void addRow(String collectionName, Row row) {}

  Row readRow(String collectionName, String rowId) {}

  Collection findCollection(String collectionName) {}
}

void main() {
  Database db = SemyonDB();

  db.addCollection("stories");
  var cage1 = Cage("name", "Supername");
  var cage2 = Cage("author", "Dima");
  var cages = [cage1, cage2];
  var story1 = Row("1", cages);
  db.addRow("stories", story1);

  // record

  // users
}
