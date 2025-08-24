import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final double? height;
  final void Function()? onPressed;
  final double? labelSize;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final double? buttonRadius;
  final String? labelLogo;
  final Color? buttonBorderColor;
  final double? width;
  final Color? buttonColorGrade;
  final String? img;
  final Color? imgColor;
  final bool? textShadow;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool? load;
  final IconData? icon;
  final Color? iconColor;

  const CommonButton({
    this.label,
    this.buttonColor,
    this.height,
    this.width,
    this.onPressed,
    this.labelSize,
    this.labelColor,
    this.labelWeight,
    this.buttonRadius,
    this.labelLogo,
    this.buttonBorderColor,
    this.buttonColorGrade,
    this.img,
    this.imgColor,
    this.textShadow,
    this.horizontalPadding,
    this.verticalPadding,
    this.load,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) => buttonColor ?? AppColors.primaryColor),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              side: BorderSide(color: buttonBorderColor ?? AppColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(buttonRadius ?? 12)),
            ),
          ),
          padding: WidgetStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20, vertical: verticalPadding ?? 10),
          ),
          elevation: WidgetStateProperty.resolveWith((states) => 0.0),
        ),
        child: load ?? false
            ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center, // Ensures centering
                children: [
                  if (icon != null) Icon(icon, color: iconColor, size: 18),
                  if (icon != null) SizedBox(width: 5),
                  if (img != null) SvgPicture.asset(img!, fit: BoxFit.contain, color: imgColor),
                  if (img != null && label != null) const SizedBox(width: 10),
                  if (label != null)
                    Flexible(
                      // Changed from Expanded to Flexible for better centering
                      child: Text(
                        label!,
                        style: TextStyle(
                          fontSize: labelSize ?? 14,
                          color: labelColor ?? AppColors.white,
                          fontWeight: labelWeight ?? FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
