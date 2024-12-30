class ModelTodo {
  late int id, userId;
  late String title;
  late bool completed;

  ModelTodo(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed});

  factory ModelTodo.jsonList(Map m1)
  {
    return ModelTodo(id: m1['id'], userId: m1['userId'], title: m1['title'], completed: m1['completed']);
  }
}

//Placement Task Day-1
//
// https://jsonplaceholder.typicode.com/todos
// 1. Fetch todos from this API
// 2. Arrange in List & Grid (Toggle View). Save status using shared preference (List or Grid)
// 3. Differentiate completed and pending todos by colour.
// 4. Apply dark and light theme and save last modified theme using shared preference.
// 5. Create attractive UI, and take proper full screen video with code with all features.
