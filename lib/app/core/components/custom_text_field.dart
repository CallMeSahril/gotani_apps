import 'package:flutter/material.dart';

import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final VoidCallback? onEditingComplete;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool noLabel;
  final int maxLines;
  final bool isBorder;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.noLabel = false,
    this.keyboardType,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.isBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (noLabel) ...[
          if (showLabel) ...[
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(12.0),
          ],
        ],
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: isBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
              enabledBorder: isBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    )
                  : InputBorder.none,
              hintText: label,
              contentPadding: EdgeInsets.all(10)),
        ),
      ],
    );
  }
}
