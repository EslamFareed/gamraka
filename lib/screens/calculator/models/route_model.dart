import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  String? from;
  String? to;
  num? cost;

  RouteModel({this.from, this.to, this.cost});

  RouteModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> e) {
    from = e.data()["from"];
    to = e.data()["to"];
    cost = e.data()["cost"];
  }

  
  RouteModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> e) {
    from = e.data()!["from"];
    to = e.data()!["to"];
    cost = e.data()!["cost"];
  }
}
