import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  String? name;
  String? address;

  CountryModel({this.name, this.address});

  CountryModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    name = e.data()["name"];
    address = e.data()["address"];
  }
}
