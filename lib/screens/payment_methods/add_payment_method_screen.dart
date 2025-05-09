import 'package:flutter/material.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/payment_methods/models/payment_model.dart';

import '../../core/app_colors.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _pay() async {
    if (_formKey.currentState!.validate()) {
      // Trigger payment logic here

      await CacheHelper.addNewPaymentMethod(
        PaymentModel(
          cardNumber: _cardNumberController.text,
          cvv: _cvvController.text,
          expireDate: _expiryDateController.text,
          name: _nameController.text,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Card")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Name on Card",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Enter name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.length != 16
                            ? 'Enter 16-digit card number'
                            : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      // keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "MM/YY",
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null ||
                                      !RegExp(
                                        r"^(0[1-9]|1[0-2])\/\d{2}$",
                                      ).hasMatch(value)
                                  ? 'Invalid date'
                                  : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null || value.length != 3
                                  ? 'Enter 3-digit CVV'
                                  : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _pay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text(
                  "Add New Card",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
