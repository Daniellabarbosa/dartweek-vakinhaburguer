import 'package:dw23_delivery_app/app/pages/order/order_page.dart';
import 'package:dw23_delivery_app/app/pages/order/widgets/controller/order_controller.dart';
import 'package:dw23_delivery_app/app/repositories/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/order/order_repository_impl.dart';



class OrderRouter extends StatelessWidget {
  const OrderRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<OrderRepository>(
      create: (_) => OrderRepositoryImpl(dio: context.read()),
      child: BlocProvider(
        create: (context) => OrderController(orderRepository: context.read()),
        child: const OrderPage(),
      ),
    );
  }
}
