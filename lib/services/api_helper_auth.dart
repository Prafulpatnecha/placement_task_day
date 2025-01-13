import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:placement_task_day/model/model_auth.dart';
import 'package:sqflite/sqflite.dart';

class ApiHelperAuth {
  ApiHelperAuth._();

  static ApiHelperAuth apiHelperAuth = ApiHelperAuth._();
  final String _apiUrl = "https://api.escuelajs.co/api/v1/users";

  Future getData() async {
    Response response = await http.get(Uri.parse(_apiUrl));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      Map map1 = json[0];
      // print(map1);
      return json;
    } else {
      return "200 Status field";
    }
  }
}

class LocalDataStore extends ChangeNotifier {
  Map dataStore = {};
  Database? database;
  List<ModelAuth> jsonModelList = [];

  LocalDataStore() {
    createLocalStore();
  }

  Future<void> createLocalStore() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contact.db');
    // await deleteDatabase(path);
    // await deleteDatabase(path);
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
        await db.execute('''CREATE TABLE Test (id INTEGER PRIMARY KEY,
              email TEXT, password TEXT,name TEXT,
               role TEXT,avatar TEXT ,creationAt TEXT,
               updatedAt TEXT,idSet INTEGER)''');
    });
    getLocalData();
  }

  Future<void> insertLocalStorage({required List jsonList}) async {
    createLocalStore();
    List<ModelAuth> jsonListStore = [];
    jsonListStore = (jsonList)
        .map(
          (e) => ModelAuth.formJson(e),
        )
        .toList();
    // print(jsonListStore);
    await database!.rawDelete('DELETE FROM Test WHERE idSet = ?', [1]);
    for (int i = 0; i < jsonListStore.length; i++) {
      database!.transaction((txn) async {
        txn.rawInsert(
            'INSERT INTO Test(id,email,password,name,role,avatar,creationAt,updatedAt,idSet) VALUES(?, ?, ?,?,?,?,?,?,?)',
            [
              jsonListStore[i].id,
              jsonListStore[i].email,
              jsonListStore[i].password,
              jsonListStore[i].name,
              jsonListStore[i].role,
              jsonListStore[i].avatar,
              jsonListStore[i].creationAt,
              jsonListStore[i].updatedAt,
              1
            ]);
      });
    }
    getLocalData();
  }

  Future<void> getLocalData()
  async {
    List list = await database!.rawQuery('SELECT * FROM Test');
    // print("-----------------------------");
    jsonModelList = (list).map((e) => ModelAuth.formJson(e),).toList();
    // for (int i = 0; i < jsonModelList.length; i++)
    // {
    //   print(jsonModelList[i].id);
    // }
    // print("-----------------------------");
    notifyListeners();
  }

  Future<void> storageIdDelete({required int id})
  async {
    await database!.rawDelete('DELETE FROM Test WHERE id = ?', [id]);
    getLocalData();
  }

  void getUpdateData({required int id,
      required String name,
      required String role})
   {
    // database!.rawUpdate(
    //     'UPDATE Test SET name = ?,role = ?, WHERE id = ?',
    //     [name,role,id]);
    database!.rawUpdate(
        '''UPDATE Test SET name = ?, role = ? WHERE id = ?''',
        [name, role, id]);
    getLocalData();
  }
}
