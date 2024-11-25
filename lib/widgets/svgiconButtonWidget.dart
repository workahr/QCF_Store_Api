import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SvgIconButtonWidget extends StatelessWidget {
  SvgIconButtonWidget({
    Key? key,
    this.color,
    required this.title,
     this.width,
    this.height,
    this.onTap,
    this.titleColor,
    this.borderColor,
    this.fontSize,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  final Color? color;
  final String title;
  final Color? titleColor;
  final Color? borderColor;
  final double? width;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  var height;
  final Function()? onTap;
  Widget? leadingIcon;
  Widget? trailingIcon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        // backgroundColor: color ?? Colors.blue,
        backgroundColor: color ?? AppColors.primary,
        // primary:  color ??  AppColors.primary,
        side: BorderSide(
          color: borderColor ??
              AppColors
                  .primary, // Change this color to your desired outline color
          width: 1.0, // Change the width of the outline
        ),
        minimumSize: width != null ? Size(width!, height ?? 50.0): null,
        maximumSize:  width != null ? Size(width!, height ?? 50.0): null,
       shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0)),

      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) leadingIcon!,
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize ?? 16.0,
              color: titleColor ?? AppColors.light,
              // fontWeight: FontWeight.w600
            ),
          ),
          if (trailingIcon != null) trailingIcon!
        ],
      ),
    );
  }
}
