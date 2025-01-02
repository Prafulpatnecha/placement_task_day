class ModelAuth {
  late String accessToken,
      refreshToken,
      username,
      firstName,
      email,
      lastName,
      gender,
      image;
  late int id;

  ModelAuth(
      {required this.accessToken,
      required this.refreshToken,
      required this.username,
      required this.firstName,
      required this.email,
      required this.lastName,
      required this.gender,
      required this.image,
      required this.id});

  factory ModelAuth.fromJson(Map m1) {
    return ModelAuth(
        accessToken: m1['accessToken'],
        refreshToken: m1['refreshToken'],
        username: m1['username'],
        firstName: m1['firstName'],
        email: m1['email'],
        lastName: m1['lastName'],
        gender: m1['gender'],
        image: m1['image'],
        id: m1['id']);
  }
}
