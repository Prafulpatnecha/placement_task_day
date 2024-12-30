import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper=ApiHelper._();
  final String _apiGetUrl = "https://jsonplaceholder.typicode.com/todos";
  Future apiGet()
  async {
    Response response = await http.get(Uri.parse(_apiGetUrl));

    if(response.statusCode == 200)
      {
        final json = jsonDecode(response.body);
        return json;
      }else{
      return "Api Not Working";
    }
  }

}