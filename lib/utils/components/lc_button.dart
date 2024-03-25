import 'package:flutter/material.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';

enum ButtonType{
  solid,
  outline,
  text
}
class LcButton extends StatefulWidget {
  final String? title;
  final VoidCallback? onPressed;
  ButtonType type;

  LcButton({
    Key? key,
    this.title,
    this.onPressed,
    this.type = ButtonType.solid
  }): super(key: key);

  @override
  State<LcButton> createState() => _LcButtonState();
}

class _LcButtonState extends State<LcButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.type == ButtonType.outline){
      return _buildOutlineButton();
    }
    else if(widget.type == ButtonType.text){
      return _buildTextButton();
    }
    return _buildSolidButton();
  }

  Widget _buildOutlineButton(){
    return OutlinedButton(
      onPressed: widget.onPressed, 
      child: Text(widget.title.toString())
    );
  }

  Widget _buildSolidButton(){
    return ElevatedButton(
      onPressed: widget.onPressed, 
      child: Text(widget.title.toString(),)
    );
  }
  Widget _buildTextButton(){
    return TextButton(
      onPressed: widget.onPressed, 
      child: Text(widget.title.toString(),)
    );
  }
}
