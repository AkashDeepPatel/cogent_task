import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    this.title,
    this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.readOnly,
  }) : super(key: key);

  String? title;
  TextInputType? textInputType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? hintText;
  TextEditingController? controller;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.labelMedium,
              )
            : const SizedBox(),
        title != null ? const SizedBox(height: 8) : const SizedBox(),
        Card(
          elevation: 3.0,
          child: SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width*0.75,
            child: TextField(
              keyboardType: textInputType ?? TextInputType.text,
              controller: controller,
              readOnly: readOnly ?? false,
              decoration: InputDecoration(
                hintText: hintText ?? "",
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                // border: const OutlineInputBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(8.0),
                //     )),
                // errorBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
                // ),
                // focusedErrorBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
