
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/api_helper_auth.dart';

class HomePageDay2 extends StatelessWidget {
  const HomePageDay2({super.key});

  @override
  Widget build(BuildContext context) {
    ApiHelperAuth apiHelperAuthTrue = Provider.of(context,listen: true);
    ApiHelperAuth apiHelperAuthFalse = Provider.of(context,listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {
      //       apiHelperAuthTrue.authLogout();
      //       print("object");
      //     }, icon: Icon(Icons.logout))
      //   ],
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
