import 'package:flutter/material.dart';
import 'package:placement_task_day/provider/provider_todo.dart';
import 'package:placement_task_day/view/bookmark/bookmark_page.dart';
import 'package:placement_task_day/view/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ProviderTodo provider = ProviderTodo();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // provider.isDark = prefs.getBool('repeat') ?? true;
  // await provider.getDarkMod();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProviderTodo(),),

    ],builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: Provider.of<ProviderTodo>(context,listen: true).isDark?ThemeMode.light:ThemeMode.dark,
      routes: {
        "/":(context)=>HomePage(),
        "/book":(context)=>BookmarkPage(),
      },
    ),);
  }
}
