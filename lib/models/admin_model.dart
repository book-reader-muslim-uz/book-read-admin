class AdminModel {
  final String id;
  final String name;
  final String password;
  AdminModel({
    required this.id,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
    };
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
