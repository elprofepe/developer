class User {
  String uid;
  String name;
  String lastName;
  String document;
  String email;
  String gender;
  String birthdate;
  String password;
  bool isValidEmail;

  User({
    this.uid,
    this.name,
    this.lastName,
    this.document,
    this.email,
    this.gender,
    this.birthdate,
    this.password,
    this.isValidEmail
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'lastName': lastName,
    'document': document,
    'email': email,
    'gender': gender,
    'birthdate': birthdate,
    'isValidEmail': isValidEmail,
  };

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] ?? "-",
        name = map['name'] ?? "-",
        lastName = map['lastName'] ?? "-",
        document = map['document'] ?? "-",
        email = map['email'] ?? "-",
        gender = map['gender'] ?? "-",
        birthdate = map['birthdate'] ?? "-",
        isValidEmail = map['isValidEmail'] ?? true;

  @override
  String toString() => toJson().toString();
}