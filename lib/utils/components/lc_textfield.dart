import 'package:flutter/material.dart';

class LcTextField extends StatefulWidget {
  TextEditingController? controller;
  bool obscureText;
  String? Function(String?)? validator;
  String? labelText;
  EdgeInsets? margin;
  Widget? suffix;
  void Function(String)? onChanged;
  bool enabled;

  LcTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.labelText,
    this.suffix,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<LcTextField> createState() => _LcTextFieldState();
}

class _LcTextFieldState extends State<LcTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        validator: widget.validator,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffix: widget.suffix
        ),
      ),
    );
  }
}