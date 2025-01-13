import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:placement_task_day/view/home/home_page.dart';
import 'package:provider/provider.dart';

import 'file_pub/toast/toast_warpper.dart';
import 'services/api_helper_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDataStore();
  runApp(MyDay2());
}

class MyDay2 extends StatelessWidget {
  const MyDay2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LocalDataStore()),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ToastWrapper(child: HomePage()),
          );
        });
  }
}