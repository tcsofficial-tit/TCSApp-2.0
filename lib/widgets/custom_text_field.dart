import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/src/flutter/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTextField extends StatelessWidget {
  final IconData ?prefixIcon;
  final String ?label;
  final Color ?prefixIconColor;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String prefixText;
  final String ?hintText;
  final String ?initialValue;
  final bool multiLines;
  final int ?maxLines;
  final int ?maxLength;
  final TextInputType? inputType;
  const CustomTextField(
      {Key ?key,
      this.prefixIcon,
      this.prefixIconColor,
      this.label,
      this.multiLines = false,
      this.maxLength,
      this.prefixText="",
      this.hintText,
      this.inputType,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.onChanged,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0x00000000), blurRadius: 11)]),
      child: TextFormField(
        inputFormatters: (maxLength == null)
            ? null
            : [
                LengthLimitingTextInputFormatter(maxLength),
              ],
        initialValue: initialValue ?? null,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        // selectionHeightStyle: BoxHeightStyle.max,
        showCursor: true,
        style: TextStyle(height: 1.5),
        maxLength: null,
        keyboardType: inputType ?? null,
        maxLines: (multiLines)
            ? (maxLines != null)
                ? maxLines
                : null
            : 1,
        decoration: InputDecoration(
          label: label!=null?Text(label!):null,
          prefixIcon: Icon(
              prefixIcon,
              color: prefixIconColor??Colors.grey,
            ),
          border: InputBorder.none,
          hintText: hintText ?? null,
          prefix: (prefixText != null) ? Text(prefixText) : null,
          prefixStyle: TextStyle(color: Colors.black),
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(15.0, 14.0, 15.0, 10.0),
          errorStyle: const TextStyle(
            fontSize:13 
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedErrorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Vx.red400),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          errorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Vx.red400),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}