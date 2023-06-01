// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotSupported_Page extends StatelessWidget {
  const NotSupported_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("This app is not yet available on this platform."),
            const SizedBox(height: 10),
            LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0xFF80ffdb),
              rightDotColor: const Color(0xFFf72585),
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
