import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeliveryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  const DeliveryButton({super.key, required this.label, this.onTap, this.width, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}