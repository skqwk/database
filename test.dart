void main(List<String> args) {
  print("Hello World");
  print(args);
  assert(args[0] == '1');

  try {
    myFunc();
  } on DataBaseException catch (de, s) {
    print(s);
  } catch (e) {
    // Anything else that is an exception
    print('Catch exception: ${e}');
    //throw Exception("Db exception");
    rethrow; // throw(e);
  } finally {
    print("Astalavista");
  }
}

void myFunc() {
  // throw new DataBaseException("something went wrong with DB");
}

class DataBaseException implements Exception {
  String message;
  DataBaseException(this.message);
}
