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
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed("/book");
          },icon: Icon(Icons.favorite_border,color: Colors.red,)),
          IconButton(onPressed: () {
            providerTodoFalse.darkMode();
          },icon: providerTodoTrue.isDark?Icon(Icons.sunny,color: Colors.red,):Icon(Icons.sunny_snowing,)),
          SizedBox(width: 5,),
        ],
        title: Text("Todos",style: TextStyle(fontWeight: FontWeight.bold),),
        // centerTitle: true,
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

          return GridView.builder(
            itemCount: providerTodoTrue.modelTodoList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                  // color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: providerTodoTrue.isDark?Colors.black:Colors.white)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                      footer: IconButton(onPressed: () {
                        String id = providerTodoTrue.modelTodoList[index].id.toString();
                        // save sharePreference
                        providerTodoFalse.shareDetails(id: id);
                      },icon: (!providerTodoTrue.bookMarkList.contains(providerTodoTrue.modelTodoList[index].id.toString()))?Icon(Icons.favorite_border,color: providerTodoTrue.isDark?Colors.black:Colors.white.withOpacity(0.8),):Icon(Icons.favorite,color: Colors.red.withOpacity(0.8),)),
                      header: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      // subtitle:
                          Center(child: Text(providerTodoTrue.modelTodoList[index].id.toString(),style: TextStyle(fontSize: 15),)),
                          (providerTodoTrue.modelTodoList[index].completed)?Text("Online",style: TextStyle(color: Colors.green),):Text("Offline",style: TextStyle(color: Colors.red),),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Divider(),
                          Text(providerTodoTrue.modelTodoList[index].title,textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
        }
      ),
    );
  }
}
