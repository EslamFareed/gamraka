import 'dart:convert';

class PaymentModel {
  String? cardNumber;
  String? expireDate;
  String? cvv;
  String? name;

  PaymentModel({
    required this.cardNumber,
    required this.cvv,
    required this.expireDate,
    required this.name,
  });

  PaymentModel.fromJson(String data) {
    Map json = jsonDecode(data);

    cardNumber = json["cardNumber"];
    cvv = json["cvv"];
    expireDate = json["expireDate"];
    name = json["name"];
  }

  String toJson() {
    Map json = {
      "cardNumber": cardNumber,
      "cvv": cvv,
      "expireDate": expireDate,
      "name": name,
    };

    return jsonEncode(json);
  }
}
