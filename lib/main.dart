import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  TripleObserver.addListener((triple) {
    if (kDebugMode) {
      print(triple);
    }
  });
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
