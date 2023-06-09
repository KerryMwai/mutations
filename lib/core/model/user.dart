class User {
  final String name;
  final String username;
  final String email;
  final String phone;

  User(
      {required this.name,
      required this.username,
      required this.email,
      required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        username: json['username'],
        email: json['email'],
        phone: json['phone']);
  }

  toJson(){
    return {
      'name':name,
      'username':username,
      'email':email,
      'phone':phone
    };
  }
}
