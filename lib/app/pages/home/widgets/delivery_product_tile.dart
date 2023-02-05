import 'package:dw23_delivery_app/app/core/extension/formatter_extension.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw23_delivery_app/app/models/product_model.dart';
import 'package:dw23_delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const DeliveryProductTile({super.key, required this.product, this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProduct = await Navigator.of(context).pushNamed("/productDetail", arguments: {
          "product": product,
          "order": order,
        });

        if (orderProduct != null) {
          controller.addOrUpdateBag(orderProduct as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.name,
                      style: context.textApp.textExtraBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.description,
                      style: context.textApp.textLight.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      product.price.currencyPTBR,
                      style: context.textApp.textMedium.copyWith(
                        fontSize: 20,
                        color: context.colors.secundary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: product.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}