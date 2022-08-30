import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:isupply/utils/cache_service.dart';

import 'app/app.dart';
import 'modules/app_module.dart';

void main() async {
  await CacheService.init();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
