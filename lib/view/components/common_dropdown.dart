import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CommonDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final String Function(T)? displayText;
  final String? hintText;
  final String? Function(T?)? validator;
  final double? height;
  final bool? isExpand;
  final bool enabled;
  final InputBorder? border;
  final Widget? icon;

  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.displayText,
    this.hintText,
    this.validator,
    this.height,
    this.isExpand,
    this.enabled = true,
    this.border,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.blackColor.withOpacity(0.1)),
    );

    return SizedBox(
      height: height,
      child: DropdownButtonFormField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        icon: icon,
        decoration: InputDecoration(
          isDense: true,
          enabled: enabled,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          labelStyle: const TextStyle(fontSize: 12),
          errorBorder: borderStyle.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: border ?? borderStyle,
          focusedBorder: border ??
              borderStyle.copyWith(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
              ),
          focusedErrorBorder: borderStyle.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: borderStyle,
        ),
        hint: Text(
          hintText ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        value: value,
        isDense: true,
        isExpanded: isExpand ?? true,
        validator: validator != null ? (val) => validator!(val) : null,
        items: items
            .map(
              (e) => DropdownMenuItem<T>(
                value: e,
                child: Text(
                  displayText != null ? displayText!(e) : e.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
