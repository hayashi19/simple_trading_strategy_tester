// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RegularTextfield extends StatelessWidget {
  String hint;
  TextInputType inputType;
  int? minLine = 1;
  int? maxLine = 3;
  bool textFocus;
  Function(bool) textFocusOnChange;
  TextEditingController textController;
  Function(String) onChangeValue;
  final Function? onEditingComplete;

  RegularTextfield({
    super.key,
    required this.hint,
    required this.inputType,
    this.minLine,
    this.maxLine,
    required this.textFocus,
    required this.textFocusOnChange,
    required this.textController,
    required this.onChangeValue,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (newFocus) => textFocusOnChange(newFocus),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: textFocus ? Colors.grey.shade700 : Colors.grey.shade800,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: TextField(
            controller: textController,
            keyboardType: inputType,
            minLines: minLine,
            maxLines: maxLine,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.only(bottom: 10),
              isDense: true,
            ),
            onChanged: (newValue) => onChangeValue(newValue),
            onEditingComplete: () => onEditingComplete!(),
          ),
        ),
      ),
    );
  }
}

class AppbarTextfield extends StatelessWidget {
  String hint;
  TextInputType inputType;
  int? minLine = 1;
  int? maxLine = 3;
  bool textFocus;
  Function(bool) textFocusOnChange;
  TextEditingController textController;
  Function(String) onChangeValue;

  AppbarTextfield({
    super.key,
    required this.hint,
    required this.inputType,
    this.minLine,
    this.maxLine,
    required this.textFocus,
    required this.textFocusOnChange,
    required this.textController,
    required this.onChangeValue,
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (newFocus) => textFocusOnChange(newFocus),
        child: TextField(
          controller: textController,
          keyboardType: inputType,
          minLines: minLine,
          maxLines: maxLine,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.only(bottom: 10),
            isDense: true,
          ),
          onChanged: (newValue) => onChangeValue(newValue),
        ),
      ),
    );
  }
}
