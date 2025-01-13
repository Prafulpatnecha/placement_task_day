import 'package:flutter/material.dart';
import 'package:placement_task_day/model/model_auth.dart';
import 'package:placement_task_day/services/api_helper_auth.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../file_pub/toast/provider.dart';
import '../../file_pub/toast/styles.dart';
import '../../file_pub/toast/type.dart';

TextEditingController textName = TextEditingController();
TextEditingController textRole = TextEditingController();
late ToastProvider toastProvider;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    LocalDataStore localDataStore = Provider.of(context, listen: true);
    LocalDataStore localDataStoreFalse = Provider.of(context, listen: false);
    toastProvider = ToastProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: localDataStore.jsonModelList.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(localDataStore.jsonModelList[index].id.toString()),
          title: Text(
              "${localDataStore.jsonModelList[index].name} / ${localDataStore.jsonModelList[index].role}"),
          subtitle: Text(localDataStore.jsonModelList[index].email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    localDataStoreFalse.storageIdDelete(
                        id: localDataStore.jsonModelList[index].id);
                    // localDataStoreFalse.storageIdDelete(id: localDataStore.jsonModelList[index].id);
                  },
                  icon: Icon(Icons.delete)),
              IconButton(onPressed: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text("data"),
                    content: Column(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    TextFormField(
                      controller: textName,
                              decoration: InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                              ),
                            ),
                    TextFormField(
                      controller: textRole,
                              decoration: InputDecoration(
                                label: Text("Role"),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                              ),
                            ),
                          ],
                    ),
                  actions: [
                    TextButton(onPressed: () {
                      localDataStoreFalse.getUpdateData(id: localDataStore.jsonModelList[index].id, name: textName.text.toString(), role: textRole.text.toString());
                      Navigator.of(context).pop();
                    }, child: Text("Save")),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text("Cansel"))
                  ],
                ),);
                // showDialog(context: context, builder: (context) => Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text("data"),
                //     TextFormField(),
                //   ],
                // ),);
              }, icon: Icon(Icons.edit))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
          if(connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi))
            {
              List jsonList = await ApiHelperAuth.apiHelperAuth.getData();
              // print(jsonList);
              localDataStoreFalse.insertLocalStorage(jsonList: jsonList);
              toastMassageInfo = "Fetching Data Successfully";
              toastProvider.showToast(NotificationType.info);
            }else{
            toastMassageError = "Please Connect Internet";
            toastProvider.showToast(NotificationType.error);
          }
        },
        child: Icon(Icons.insert_drive_file_outlined),
      ),
    );
  }
}
