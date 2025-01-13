

class ModelAuth {
  late String email,password,name,role,avatar,creationAt,updatedAt;
  late int id;

  ModelAuth(
      {required this.email,
      required this.password,
      required this.name,
      required this.role,
      required this.avatar,
      required this.creationAt,
      required this.updatedAt,
      required this.id});

  factory ModelAuth.formJson(Map m1)
  {
    return ModelAuth(email: m1['email'],
        password: m1['password'],
        name: m1['name'],
        role: m1['role'],
        avatar: m1['avatar'],
        creationAt: m1['creationAt'],
        updatedAt: m1['updatedAt'],
        id: m1['id'],
    );
  }
}

