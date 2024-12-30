import 'package:flutter/material.dart';
import 'package:placement_task_day/provider/provider_todo.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderTodo providerTodoTrue = Provider.of(context, listen: true);
    ProviderTodo providerTodoFalse = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: providerTodoTrue.apiCalling(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
            {
              return CircularProgressIndicator();
            }
          if(!snapshot.hasData)
            {
              return Center(child: CircularProgressIndicator());
            }

          return ListView.builder(
            itemCount: providerTodoTrue.modelTodoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  String id = providerTodoTrue.modelTodoList[index].id.toString();
                  // save sharePreference
                  providerTodoFalse.shareDetails(id: id);
                },
                leading: Text(providerTodoTrue.modelTodoList[index].id.toString(),style: TextStyle(fontSize: 15),),
                title: Text(providerTodoTrue.modelTodoList[index].title),
                subtitle: (providerTodoTrue.modelTodoList[index].completed)?Text("Online",style: TextStyle(color: Colors.green),):Text("Offline",style: TextStyle(color: Colors.red),),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.task_alt),
      ),
    );
  }
}
