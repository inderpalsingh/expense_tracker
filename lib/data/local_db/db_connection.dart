import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  DbConnection._();

  static final DbConnection db = DbConnection._();

  Database? myDb;

  /// creating global static values
  static const String TABLE_USER_ID = 'uid';
  static const String TABLE_USER = 'users';
  static const String TABLE_USER_NAME = 'users_name';
  static const String TABLE_USER_EMAIL = 'user_email';
  static const String TABLE_USER_PASS = 'user_pass';

  /// expense
  static const String TABLE_EXPENSE_ID = 'uid';
  static const String TABLE_EXPENSE = 'expense';
  static const String TABLE_EXPENSE_TITLE = 'expense_title';
  static const String TABLE_EXPENSE_DESC = 'expense_desc';
  static const String TABLE_EXPENSE_TIMESTAMP = 'expense_time';
  static const String TABLE_EXPENSE_AMOUNT = 'expense_amount';
  static const String TABLE_EXPENSE_BALANCE = 'expense_balance';

  Future<Database> getDB() async {
    if (myDb != null) {
      return myDb!;
    } else {
      myDb = await initDb();
      return myDb!;
    }
  }

  Future<Database> initDb() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var setFilePath = join(rootPath.path, 'expense_app.db');
    return await openDatabase(setFilePath, version: 1, onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $TABLE_USER ($TABLE_USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_USER_NAME TEXT, $TABLE_USER_EMAIL unique TEXT , $TABLE_USER_PASS TEXT)'
            'CREATE TABLE $TABLE_EXPENSE ($TABLE_EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_EXPENSE_TITLE TEXT, $TABLE_EXPENSE_DESC TEXT , $TABLE_EXPENSE_TIMESTAMP TEXT , $TABLE_EXPENSE_AMOUNT TEXT , $TABLE_EXPENSE_BALANCE TEXT)');
    });
  }
  
  
  
}
