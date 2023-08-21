import 'dart:io';

import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File file = ModalRoute.of(context)?.settings.arguments as File;

    return Scaffold(
      body: Center(
        child: Image.file(File(file.path),
             fit: BoxFit.cover),
      ),
    );
    ;
  }
}
