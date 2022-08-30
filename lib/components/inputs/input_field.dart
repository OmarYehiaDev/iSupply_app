import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final double? width;
  final bool obscureText;
  final bool? isValid;
  final bool? enabled;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool expands;
  final Widget? counter;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool numbersOnly;
  final int? maxChars;
  final EdgeInsets? margin;
  const InputField({
    Key? key,
    this.controller,
    this.maxChars,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.isValid,
    this.prefixIcon,
    this.prefix,
    this.labelText,
    this.labelStyle,
    this.counter,
    this.expands = false,
    this.width,
    this.margin = const EdgeInsets.only(bottom: 20.0, top: 10),
    this.onTap,
    this.hintText,
    this.enabled,
    this.numbersOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = 50.0;
    if (expands) h = 150.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: labelStyle,
          ),
        Container(
          width: width,
          height: (isValid != null) ? (h + (!isValid! ? 20 : 0)) : h,
          margin: margin,
          child: TextFormField(
            maxLength: maxChars,
            inputFormatters: numbersOnly
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            enabled: enabled ?? true,
            onTap: onTap,
            expands: expands,
            maxLines: !expands ? 1 : null,
            controller: controller,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            obscureText: obscureText,
            textAlignVertical: expands ? TextAlignVertical.top : TextAlignVertical.bottom,
            decoration: InputDecoration(
              counter: maxChars!=null
                  ? Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text("${controller!.text.length}/$maxChars"),
                    )
                  : counter,
              prefixIcon: prefixIcon,
              prefix: prefix,
              hintText: hintText,
              errorStyle: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
