import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'file_pub/toast/toast_warpper.dart';
import 'services/api_helper_auth.dart';
import 'view/home/home_page_day_2.dart';
import 'view/login/auth_login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiHelperAuth.oneTimeCalling();
  runApp(MyDay2());
}

class MyDay2 extends StatelessWidget {
  const MyDay2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ApiHelperAuth()),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ToastWrapper(child: AuthProcessPage()),
            // initialRoute: "/login",
            // routes: {
            //   "/":(context)=>AuthProcessPage(),
            //   // "/":(context)=>AuthLoginPage(),
            //   // "/": (context) => ToastWrapper(child: AuthLoginPage()),
            //   "/home": (context) => HomePageDay2(),
            // },
          );
        });
  }
}



class AuthProcessPage extends StatefulWidget {
  const AuthProcessPage({super.key});

  @override
  State<AuthProcessPage> createState() => _AuthProcessPageState();
}

class _AuthProcessPageState extends State<AuthProcessPage> {
  @override
  Widget build(BuildContext context) {
    // ApiHelperAuth.oneTimeCalling();
    ApiHelperAuth apiHelperAuthTrue = Provider.of(context,listen: true);
    print("=============================================");
    print("${apiHelperAuthTrue.email}<--------------------");
    print("=============================================");
    ApiHelperAuth apiHelperAuthFalse = Provider.of(context,listen: false);
    apiHelperAuthFalse.postShareLocalStorageEmail();
    // apiHelperAuthFalse.authLogout();
    return (apiHelperAuthTrue.email =="")?AuthLoginPage():HomePageDay2();
  }
}
