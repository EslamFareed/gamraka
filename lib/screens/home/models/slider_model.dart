import 'package:cloud_firestore/cloud_firestore.dart';

class SliderModel {
  String? link;
  String? value;

  SliderModel({this.link, this.value});

  SliderModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    link = e.data()["link"];
    value = e.data()["value"];
  }
}
