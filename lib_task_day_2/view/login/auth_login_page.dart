import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../file_pub/toast/provider.dart';
import '../../file_pub/toast/styles.dart';
import '../../file_pub/toast/type.dart';
import '../../services/api_helper_auth.dart';

// late ToastProvider toastProvider;
TextEditingController textEmail = TextEditingController();
TextEditingController textPassword = TextEditingController();

class AuthLoginPage extends StatelessWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // toastProvider = ToastProvider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textEmail,
                decoration: InputDecoration(
                  label: Text(
                    "Email",
                    style: TextStyle(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textPassword,
                decoration: InputDecoration(
                  label: Text(
                    "Password",
                    style: TextStyle(color: Colors.cyan),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CupertinoButton(
              color: Colors.greenAccent,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (textEmail.text.isNotEmpty && textEmail.text.isNotEmpty) {
                  ApiHelperAuth apiHelperAuth = Provider.of(context,listen: false);
                  String authValue = await apiHelperAuth.authGetLogin(
                    username: textEmail.text.toString(),
                    password: textPassword.text.toString(),
                  );
                  if (authValue == "Login Successfully") {
                    toastMassageSuccess = authValue;
                    // toastProvider.showToast(NotificationType.success);
                  } else {
                    toastMassageError = authValue;
                    // toastProvider.showToast(NotificationType.error);
                  }
                } else {
                  toastMassageError = "Email And Password Must be Required";
                  // toastProvider.showToast(NotificationType.error);
                }
              },
            ),
            Spacer(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   child: Icon(Icons.import_contacts),
      // ),
    );
  }
}
