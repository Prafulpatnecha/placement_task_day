import 'package:flutter/cupertino.dart';
import 'package:placement_task_day/model/model_todo.dart';
import 'package:placement_task_day/services/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderTodo extends ChangeNotifier {
  List<ModelTodo> modelTodoList = [];
  List<String> bookMarkList = [];

  ProviderTodo() {
    apiCalling();
    getShareDetails();
  }

  Future<List> apiCalling() async {
    final jsonList = await ApiHelper.apiHelper.apiGet();
    modelTodoList = (jsonList as List)
        .map(
          (e) => ModelTodo.jsonList(e),
        )
        .toList();
    // print(modelTodoList[5].title);
    return jsonList;
  }

  Future<void> shareDetails({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!bookMarkList.contains(id)) {
      bookMarkList.add(id);
      await prefs.setStringList('items', bookMarkList);
      getShareDetails();
    } else {
      print("Id was already existing");
      notifyListeners();
    }
  }

  Future<void> getShareDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList('items') ?? [];
    bookMarkList = items;
    print(bookMarkList);
    notifyListeners();
  }
}
