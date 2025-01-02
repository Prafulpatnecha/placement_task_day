//Placement Task Day - 2
// Users API: https://dummyjson.com/users
// Auth API: https://dummyjson.com/auth/login
//
// - Create a Login System App
// - Allow only Users API's user to log in and authenticate users using Auth API.
// - Auth API supports POST type and takes references from this doc: https://dummyjson.com/docs/auth
// - After successfully logging in, navigate the user to the homepage where he should show their basic detail in Listview and after clicking open another detail page.
// - Set a logout button which navigates the user to the login page again.
// - Also store all user details(all) that are logged in successfully in permanent storage without using SQLite & Firebase.
// - Create attractive UI & Proper directory structure

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_auth.dart';

class ApiHelperAuth extends ChangeNotifier {
  String email = "";
  String password = "";
  final String _url = "https://dummyjson.com/auth/login";
  ModelAuth? modelAuth;

  ApiHelperAuth();
  ApiHelperAuth.oneTimeCalling()
  {
    // postShareLocalStorageEmail();
  }


  Future<String> authGetLogin({required String username, password}) async {
    Response response = await http.post(
      Uri.parse(
        _url,
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      Map m1 = json;
      print("++++++++++++++++++++++++++++++++1++++++++++++++++++++++++++++++++");
      print("++++++++++++++++++++++++++++++++1++++++++++++++++++++++++++++++++");
      print(m1["message"]??m1["username"]);
      print("++++++++++++++++++++++++++++++++1++++++++++++++++++++++++++++++++");
      if ((m1["message"] ?? m1["username"]) == username) {
        // username,password share local Storage
      print(m1);
        modelAuth = ModelAuth.fromJson(m1);
        getShareLocalStorageEmail(email: username,password: password);
        print(modelAuth!.id);
        return "Login Successfully";
      } else if ((m1["message"] ?? m1["username"]) == "Username and password required") {
        //   error Massage Show
        return "Username and password required";
      } else if("Invalid credentials" == (m1["message"] ?? m1["username"])) {
        //   error Massage Show
        return "Password Invalid";
      }else{
        return "Check Your Internet";
      }
    } else {
      final json = jsonDecode(response.body);
      Map m1 = json;
      print("+++++++++++++++++++++++++++++++++++2+++++++++++++++++++++++++++++");
      print(m1);
      print("++++++++++++++++++++++++++++++++++2++++++++++++++++++++++++++++++");
      print(m1["message"]);
      print("++++++++++++++++++++++++++++++++++++2++++++++++++++++++++++++++++");
      if ((m1["message"]??m1["username"]) == "Invalid credentials") {
        //   error Massage Show
        return "Password Invalid";
      } else if ((m1["message"] ?? m1["username"]) == "Username and password required") {
        //   error Massage Show
        return "Username and password required";
      } else if("Invalid credentials" == (m1["message"] ?? m1["username"])) {
        //   error Massage Show
        return "Password Invalid";
      }else{
        return "Check Your Internet";
      }
      //   Show error massage.
    }
  }

  Future<void> getShareLocalStorageEmail(
      {required String email, password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    this.email = email;
    this.password = password;
    await prefs.setString('email', "${email}_$password");
    print(this.email);
    notifyListeners();
  }

  Future<void> postShareLocalStorageEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('email') ?? "";
    if(value.isNotEmpty)
      {
        email = value.split("_").sublist(0,1).join("");
        password = value.split("_").sublist(1,2).join("");
      }
    print("******************************************************************");
    print(email);
    print(password);
    print("******************************************************************");
    // notifyListeners();
  }

  Future<void> authLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    email = "";
    password = "";
    notifyListeners();
  }

  void jsonFetch() {}
}
