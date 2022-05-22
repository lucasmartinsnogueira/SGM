import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? message;
  final bool? popOnCancel;
  final Function()? onConfirmPressed;
  final String? title;
  final String? confirmMsg;
  final String? cancelMsg;
  final Widget? container;

  const CustomTextFormField({Key? key, 
    this.message,
    this.popOnCancel = false,
    this.title,
    this.onConfirmPressed,
    this.confirmMsg,
    this.cancelMsg, 
    this.container,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}