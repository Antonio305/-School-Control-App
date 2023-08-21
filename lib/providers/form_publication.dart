import 'package:flutter/material.dart';

class ValidateFormPublication extends ChangeNotifier {
//  for publication
  bool _status = false;

  bool get statusUpload => _status;

  set statusUpload(bool status) {
    _status = status;
    notifyListeners();
  }
}
