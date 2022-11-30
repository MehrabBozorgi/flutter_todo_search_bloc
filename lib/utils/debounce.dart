import 'dart:async';

import 'package:flutter/foundation.dart';

class Debounce {
  int millisecond;

  Debounce({this.millisecond = 500});

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: millisecond), action);
  }
}
