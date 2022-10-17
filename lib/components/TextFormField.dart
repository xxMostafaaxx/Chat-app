import 'package:flutter/material.dart';

Widget defaultTextForm({
  required String? Function(String?)? validator,
  required Icon? pref,
  IconData? suffix,
  TextInputType? type,
  Function()? suffixPressed,
  required String labelText,
  required String hintText,
  required Function(String)? onChanged,
  bool isPassword = false,
}) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        keyboardType: type,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            prefixIcon: pref,
            suffixIcon: suffix != null
                ? IconButton(
                    icon: Icon(
                      suffix,
                      color: Colors.blue[200],
                    ),
                    onPressed: suffixPressed,
                  )
                : null,
            contentPadding: const EdgeInsets.all(25),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white)),
      ),
    );
