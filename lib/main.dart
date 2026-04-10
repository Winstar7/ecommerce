import 'package:ecommerce/presentation/bindings/app_binding.dart';
import 'package:ecommerce/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/bindings/app_binding.dart';
import 'presentation/pages/product_page.dart';
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();

  await Hive.openBox(AppConstants.productBox);
  await Hive.openBox(AppConstants.cartBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}