import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final void Function() onPressed;
  final bool disabled;
  final String text;
  final bool isOutlined;
  const InputButton({
    Key? key,
    required this.text,
    this.isOutlined = false,
    this.disabled = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (!disabled) ? onPressed : null,
      style: ButtonStyle(
        shape: isOutlined
            ? MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : null,
        backgroundColor: MaterialStateProperty.all(
          isOutlined ? Colors.white : Theme.of(context).primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: isOutlined
              ? TextStyle(
                  color: Theme.of(context).primaryColor,
                )
              : null,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
