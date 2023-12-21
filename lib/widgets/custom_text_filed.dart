import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metatube/utils/app_theme.dart';
import 'package:metatube/utils/snack_bar_utils.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({required this.hintText,
    this.maxLine,
    required this.maxLength,
    required this.controller,
    super.key});

  int? maxLine;
  int maxLength;
  String hintText;

  TextEditingController controller;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();



  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipboard(BuildContext context , String text){
    Clipboard.setData(ClipboardData(text: text));
    SnakeBarUtils.showSnakBar(context, Icons.content_copy, "Copied to Clipboard");
  }



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLine,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme.hintStyle,
        hintText: widget.hintText,
        counterStyle: AppTheme.counterStyle,
        border: const OutlineInputBorder(),
        suffix:_copyButton(context),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.accent,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.medium,
          ),
        ),

      ),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isEmpty?null:() => copyToClipboard(context, widget.controller.text),
      color: AppTheme.accent,
      disabledColor: AppTheme.medium,
      splashRadius: 20,
      splashColor: AppTheme.accent,
      iconSize: 20,
      icon: const Icon(Icons.copy_rounded,),);
  }
}
