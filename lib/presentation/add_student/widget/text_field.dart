import 'package:flutter/material.dart';

Widget buildTextField(TextEditingController controller, String hintText,
    String validationMessage) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
        ),
      ),
    ),
  );
}
