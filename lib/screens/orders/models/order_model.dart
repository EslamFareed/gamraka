import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final num shippingCost;
  final num weight;
  final num taxes;
  final String itemDesc;
  final DateTime createdAt;
  final String itemName;
  final num total;
  final String methodType;
  final DateTime pickupDate;
  final String from;
  final num itemPrice;
  final String to;
  final Category category;
  final User user;
  final String status;
  final String statusDesc;
  final String id;
  final String verificationImage;

  OrderModel({
    required this.shippingCost,
    required this.weight,
    required this.taxes,
    required this.itemDesc,
    required this.createdAt,
    required this.itemName,
    required this.total,
    required this.methodType,
    required this.pickupDate,
    required this.from,
    required this.itemPrice,
    required this.to,
    required this.category,
    required this.user,
    required this.status,
    required this.statusDesc,
    required this.id,
    required this.verificationImage,
  });

  factory OrderModel.fromJson(
    QueryDocumentSnapshot<Map<String, dynamic>> json,
  ) {
    return OrderModel(
      id: json.id,
      shippingCost: json.data()['shippingCost'],
      weight: json.data()['weight'],
      taxes: json.data()['taxes'],
      itemDesc: json.data()['itemDesc'],
      createdAt: DateTime.parse(json.data()['createdAt']),
      itemName: json.data()['itemName'],
      total: json.data()['total'],
      methodType: json.data()['methodType'],
      pickupDate: DateTime.parse(json.data()['pickupDate']),
      from: json.data()['from'],
      itemPrice: json.data()['itemPrice'],
      to: json.data()['to'],
      category: Category.fromJson(json.data()['category']),
      user: User.fromJson(json.data()['user']),
      status: json.data()['status'],
      statusDesc: json.data()['statusDesc'],
      verificationImage: json.data()['verificationImage'],
    );
  }
}

class Category {
  final int fees;
  final String name;
  final String icon;

  Category({required this.fees, required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(fees: json['fees'], name: json['name'], icon: json['icon']);
  }

  Map<String, dynamic> toJson() {
    return {'fees': fees, 'name': name, 'icon': icon};
  }
}

class User {
  final String uid;
  final String image;
  final String phone;
  final String name;
  final String idNumber;

  User({
    required this.uid,
    required this.image,
    required this.phone,
    required this.name,
    required this.idNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      image: json['image'],
      phone: json['phone'],
      name: json['name'],
      idNumber: json['idNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'image': image,
      'phone': phone,
      'name': name,
      'idNumber': idNumber,
    };
  }
}
