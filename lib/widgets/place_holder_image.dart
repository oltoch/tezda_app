import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    super.key,
    this.maxHeight,
    this.isTransparent = false,
  });

  final double? maxHeight;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight ?? double.infinity),
      decoration: BoxDecoration(
        color: isTransparent ? Colors.transparent : const Color(0xFFEDEDE9),
        border: Border.all(
            width: 0.5,
            color: isTransparent ? Colors.transparent : Colors.grey),
      ),
      child: const Center(
          child: Icon(
        Icons.image_outlined,
        size: 40,
      )),
    );
  }
}
