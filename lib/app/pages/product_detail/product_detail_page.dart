import 'package:dw23_delivery_app/app/core/extension/formatter_extension.dart';
import 'package:dw23_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw23_delivery_app/app/core/ui/helpers/size_extesions.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw23_delivery_app/app/models/product_model.dart';
import 'package:dw23_delivery_app/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';


class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const ProductDetailPage({super.key, required this.product, required this.order});
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void onInit() {
    super.onInit();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmeDelete(int amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Deseja excluir o produto?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancelar",
                style: context.textApp.textBold.copyWith(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(
                  OrderProductDto(product: widget.product, amount: amount),
                );
              },
              child: Text(
                "Confirmar",
                style: context.textApp.textBold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: Column(
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.name,
              style: context.textApp.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              Container(
                height: 68,
                width: context.percentWidth(.5),
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, amout) {
                    return DeliveryIncrementDecrementButton(
                      amout: amout,
                      decrementPress: () {
                        controller.decrement();
                      },
                      incrementPress: () {
                        controller.increment();
                      },
                    );
                  },
                ),
              ),
              Container(
                width: context.percentWidth(.5),
                height: 68,
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, amount) {
                    return ElevatedButton(
                      style: amount == 0 ? ElevatedButton.styleFrom(backgroundColor: Colors.redAccent) : null,
                      onPressed: () {
                        if (amount == 0) {
                          _showConfirmeDelete(amount);
                        } else {
                          Navigator.of(context).pop(
                            OrderProductDto(product: widget.product, amount: amount),
                          );
                        }
                      },
                      child: Visibility(
                        visible: amount > 0,
                        replacement: Text(
                          "Excluir Produto",
                          style: context.textApp.textExtraBold,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Adicionar",
                              style: context.textApp.textExtraBold.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: AutoSizeText(
                                (widget.product.price * amount).currencyPTBR,
                                maxFontSize: 13,
                                minFontSize: 5,
                                maxLines: 1,
                                style: context.textApp.textExtraBold.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}