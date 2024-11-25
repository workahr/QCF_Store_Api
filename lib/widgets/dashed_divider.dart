import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double spacing;

  const DashedDivider({
    super.key,
    this.color = Colors.grey,
    this.height = 1,
    this.dashWidth = 8,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double totalWidth = constraints.maxWidth;
        final int dashCount = (totalWidth / (dashWidth + spacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}
