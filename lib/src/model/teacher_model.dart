class Teacher {
  String name;
  String email;
  String phone;
  String document;
  bool isAttention;

  Teacher({
    this.name,
    this.email,
    this.phone,
    this.document,
    this.isAttention
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'document': document,
    'isAttention': isAttention,
  };

  Teacher.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "-",
        email = map['email'] ?? "-",
        phone = map['phone'] ?? "-",
        document = map['document'] ?? "-",
        isAttention = map['isAttention'] ?? true;

  @override
  String toString() => toJson().toString();
}