// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RegularFlatButton extends StatelessWidget {
  String title;
  Color bgColor;
  Function onTap;
  RegularFlatButton({
    Key? key,
    required this.title,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
