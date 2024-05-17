
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  DbConnection._();

  static final DbConnection dbInstance = DbConnection._();

  static String loginCheckLoginID = "UID";

  Database? myDb;

  /// creating global static values
  static const String TABLE_USER_ID = 'uid';
  static const String TABLE_USER = 'users';
  static const String TABLE_USER_NAME = 'users_name';
  static const String TABLE_USER_EMAIL = 'user_email';
  static const String TABLE_USER_PASS = 'user_pass';

  /// expense
  static const String TABLE_EXPENSE_ID = 'eid';
  static const String TABLE_EXPENSE = 'expense';
  static const String TABLE_EXPENSE_TITLE = 'expense_title';
  static const String TABLE_EXPENSE_DESC = 'expense_desc';
  static const String TABLE_EXPENSE_TIMESTAMP = 'expense_time';
  static const String TABLE_EXPENSE_AMOUNT = 'expense_amount';
  static const String TABLE_EXPENSE_BALANCE = 'expense_balance';
  static const String TABLE_EXPENSE_TYPE = 'expense_type';

  /// category
  static const String TABLE_NAME_CAT='category';
  static const String TABLE_COLUMN_CATID='catId';
  static const String TABLE_COLUMN_CATNAME='name';
  static const String TABLE_COLUMN_CATIMAGE='image';

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
    return await openDatabase(setFilePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $TABLE_EXPENSE ($TABLE_EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_USER_ID integer, $TABLE_COLUMN_CATID integer, $TABLE_EXPENSE_TITLE TEXT, $TABLE_EXPENSE_DESC TEXT , $TABLE_EXPENSE_TIMESTAMP TEXT , $TABLE_EXPENSE_AMOUNT TEXT , $TABLE_EXPENSE_BALANCE TEXT, $TABLE_EXPENSE_TYPE text )');
      await db.execute(
          'CREATE TABLE $TABLE_USER ($TABLE_USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_USER_NAME TEXT, $TABLE_USER_EMAIL TEXT unique , $TABLE_USER_PASS TEXT)');
    });
  }
  
  
  Future<bool> signUpUser({required UserModel userModel})async{
    var db = await getDB();
    bool checkEmailAccount = await checkEmailExists(userModel.email);
    bool accountCreated = false;
    if(!checkEmailAccount){
      var rowsEffected = await db.insert(TABLE_USER, userModel.toMap());
      accountCreated = rowsEffected>0;
    }
    return accountCreated;
    
  }
  
  Future<bool> checkEmailExists(String email)async{
    var db = await getDB();
    var checkEmail = await db.query(TABLE_USER, where: '$TABLE_USER_EMAIL = ?', whereArgs: [email] );
    return checkEmail.isNotEmpty;
  }
  
  
  /// User login
  Future<bool> loginUser ({required String email,required String pass}) async{
    var db = await getDB();
    var checkUserExists = await db.query(TABLE_USER, where: '$TABLE_USER_EMAIL = ? AND $TABLE_USER_PASS = ?', whereArgs: [email, pass] );
    
    if(checkUserExists.isNotEmpty){
     setUID(UserModel.fromMap(checkUserExists[0]).uid);
    }
    return checkUserExists.isNotEmpty;
  }


  // fetchUser()async{
  //   var db = await getDB();
  //   var userUid = await getUID();
  //   print(userUid);
  //   await db.query(TABLE_USER, where: '$TABLE_USER_ID = ?', whereArgs: ['$userUid']);
  //  
  // }


  /// get USER UID
  Future<int> getUID()async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(loginCheckLoginID)!;
  }

  //// set USER UID
  void setUID(int uid) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(loginCheckLoginID,uid);
  }
  
  
  /// For Expense 
  Future<List<ExpenseModel>> fetchExpense() async{
    var db = await getDB();
    var userUid = await getUID();
    
    var getUser = await db.query(TABLE_EXPENSE, where: '$TABLE_USER_ID = ?', whereArgs: ['$userUid']);
    
    List<ExpenseModel> getDbUsers = [];
    
    for(Map<String, dynamic> mapData in getUser){
      var dataModel = ExpenseModel.fromMap(mapData);
      getDbUsers.add(dataModel);
    }
    return getDbUsers;
    
  }
  
  Future<bool> addExpense({required ExpenseModel expenseModel})async{
    var db = await getDB();
    var userId = await getUID();
    expenseModel.userId = userId;
    var check = await db.insert(TABLE_EXPENSE, expenseModel.toMap());
    return check>0;
  }
  
}
