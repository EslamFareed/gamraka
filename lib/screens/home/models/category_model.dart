import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? name;
  String? icon;
  num? fees;

  CategoryModel({this.name, this.fees, this.icon});

  CategoryModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    name = e.data()["name"];
    icon = e.data()["icon"];
    fees = e.data()["fees"];
  }
}
