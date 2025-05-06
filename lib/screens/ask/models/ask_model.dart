class AskModel {
  final DateTime createdAt;
  final String question;
  final String answer;
  final User user;

  AskModel({
    required this.createdAt,
    required this.question,
    required this.answer,
    required this.user,
  });

  factory AskModel.fromJson(Map<String, dynamic> json) {
    return AskModel(
      createdAt: DateTime.parse(json['createdAt']),
      question: json['question'],
      answer: json['answer'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'question': question,
      'answer': answer,
      'user': user.toJson(),
    };
  }
}

class User {
  final String uid;
  final String phone;
  final String name;
  final String idNumber;
  final String image;

  User({
    required this.uid,
    required this.idNumber,
    required this.phone,
    required this.name,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      idNumber: json['idNumber'],
      image: json['image'],
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'idNumber': idNumber,
      'image': image,
      'phone': phone,
      'name': name,
    };
  }
}
