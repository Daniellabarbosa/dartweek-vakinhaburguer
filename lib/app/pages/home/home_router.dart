import 'package:dw23_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw23_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw23_delivery_app/app/pages/home/home_page.dart';
import 'package:dw23_delivery_app/app/repositories/products/products_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductsRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read<ProductsRepositoryImpl>(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}