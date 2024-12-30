import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_todo.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderTodo providerTodoTrue = Provider.of(context, listen: true);
    ProviderTodo providerTodoFalse = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("BookMark"),
      ),
      body: ListView.builder(
        itemCount: providerTodoTrue.modelTodoList.length,
        itemBuilder: (context, index) => (providerTodoTrue.bookMarkList.contains(providerTodoTrue.modelTodoList[index].id.toString()))?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: providerTodoTrue.isDark?Colors.black:Colors.white)
            ),
            child: ListTile(
              trailing: (!providerTodoTrue.bookMarkList.contains(providerTodoTrue.modelTodoList[index].id.toString()))?Icon(Icons.favorite_border,color: Colors.black.withOpacity(0.8),):Icon(Icons.favorite,color: Colors.red.withOpacity(0.8),),
              onTap: () {
                String id = providerTodoTrue.modelTodoList[index].id.toString();
                // save sharePreference
                providerTodoFalse.shareDetails(id: id);
              },
              leading: Text(providerTodoTrue.modelTodoList[index].id.toString(),style: TextStyle(fontSize: 15),),
              title: Text(providerTodoTrue.modelTodoList[index].title),
              subtitle: (providerTodoTrue.modelTodoList[index].completed)?Text("Online",style: TextStyle(color: Colors.green),):Text("Offline",style: TextStyle(color: Colors.red),),
            ),
          ),
        ):Container(),
      ),
    );
  }
}
