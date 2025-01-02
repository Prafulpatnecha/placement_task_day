import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placement_task_day/model/model_auth.dart';
import 'package:provider/provider.dart';

import '../../services/api_helper_auth.dart';

class HomePageDay2 extends StatelessWidget {
  const HomePageDay2({super.key});

  @override
  Widget build(BuildContext context) {
    ApiHelperAuth apiHelperAuthTrue = Provider.of(context, listen: true);
    ApiHelperAuth apiHelperAuthFalse = Provider.of(context, listen: false);
    return (apiHelperAuthTrue.modelAuth==null)? Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          SizedBox(height: 30,),
          CupertinoButton(color: Colors.orange,
              child: Text(
                "Reload",
                style: TextStyle(color: Colors.white),
              ), onPressed: () {
                apiHelperAuthFalse.updateChange();
              },)
        ],
      ),
    ): Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                apiHelperAuthTrue.authLogout();
                print("object");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage("${apiHelperAuthTrue.modelAuth!.image}.jpg"),fit: BoxFit.contain)
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text(apiHelperAuthTrue.modelAuth!.username.toString()+" "+ apiHelperAuthTrue.modelAuth!.lastName.toString()),
            subtitle: Text(apiHelperAuthTrue.modelAuth!.email.toString()),
            trailing: Text(apiHelperAuthTrue.modelAuth!.gender),
            leading: Text(apiHelperAuthTrue.modelAuth!.id.toString()),
          )
        ],
      ),
    );
  }
}
