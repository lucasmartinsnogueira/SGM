import 'package:flutter/material.dart';
import 'package:sgm/shared/help/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final bool? activated;
  final bool? enable;
  final String? label;
  final int? maxlines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField(
      {Key? key,
      this.activated = false,
      this.enable = true,
      this.label,
      this.maxlines,
      this.keyboardType,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
          enabled: widget.enable,
          controller: widget.controller,
          validator: widget.validator,
          cursorColor: pink,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxlines,
          decoration: InputDecoration(
            enabled: widget.activated!,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: pink, width: 3)),
            focusColor: pink,
            hoverColor: pink,
            hintText: widget.label,
            fillColor: pink,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: pink,
                width: 2.0,
              ),
            ),
          )),
    );
}
