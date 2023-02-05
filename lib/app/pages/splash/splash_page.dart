import 'package:dw23_delivery_app/app/core/ui/helpers/size_extesions.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:easy_comp/easy_comp.dart';
import 'package:flutter/material.dart';



class SplashPage extends BaseWidget {
  SplashPage({super.key});
  @override
  Widget builder(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: Image.asset(
                  "assets/images/lanche.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: context.percentHeight(0.30)),
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 80),
                  DeliveryButton(
                    label: "ACESSAR",
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/home");
                    },
                    width: context.percentWidth(.60),
                    height: 35,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}