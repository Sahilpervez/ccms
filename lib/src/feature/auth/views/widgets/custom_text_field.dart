import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class CustomTextFieldBuilder extends StatelessWidget {
  const CustomTextFieldBuilder(
      {super.key,
      required controller,
      this.title,
      required this.hint,
      this.maxlines,
      this.textInputAction,
      this.padding,
      this.topGap,
      this.bottomGap,
      this.enable = true,
      this.trailing,
      this.keyboardType,this.titlePadding,this.prefixIcon})
      : _controller = controller;
  final TextEditingController? _controller;
  final String? title;
  final String hint;
  final int? maxlines;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final double? topGap;
  final double? bottomGap;
  final bool enable;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final EdgeInsets? titlePadding;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: titlePadding??EdgeInsets.zero,
            child: Text(
              title!,
              style: const TextStyle(
                color: Color(0xFF2C2C2C),
                fontSize: 17,
                fontFamily: AssetFonts.inter,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        SizedBox(height: topGap ?? 10),
        CustomTextField(
          controller: _controller,
          hint: hint,
          maxlines: maxlines,
          textInputAction: textInputAction,
          padding: padding,
          enable: enable,
          trailing: trailing,
          keyboardType: keyboardType,prefixIcon: prefixIcon,
        ),
        SizedBox(height: bottomGap ?? 24),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required TextEditingController? controller,
      required this.hint,
      this.maxlines,
      this.trailing,
      this.textInputAction,
      this.padding,
      this.enable = true,
      this.isObscure = false,
      this.keyboardType,this.prefixIcon})
      : _controller = controller;

  final TextEditingController? _controller;
  final String hint;
  final int? maxlines;
  final Widget? trailing;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final bool enable;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextFormField(
        controller: _controller,
        scrollPadding: const EdgeInsets.only(bottom: 50),
        decoration: InputDecoration(
          suffixIcon: trailing,
          prefixIcon: prefixIcon,
          // border: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1.2, color: Color(0xFF818181)),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.2, color: Color.fromARGB(255, 83, 83, 83)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 82, 81, 81),
              // color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintText: hint,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.2, color: Color.fromARGB(255, 53, 53, 53)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabled: enable,
          hintStyle: const TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 15,
            fontFamily: AssetFonts.inter,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: AssetFonts.inter,
          fontWeight: FontWeight.w400,
        ),
        textInputAction: textInputAction,
        maxLines: maxlines,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        keyboardType: keyboardType,
        obscureText: isObscure,
      ),
    );
  }
}



class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {super.key,
      required TextEditingController? controller,
      required this.hint,
      this.trailing,
      this.textInputAction,
      this.padding,
      this.isObscure = true,
      this.enable = true,
      this.keyboardType,this.prefixIcon})
      : _controller = controller;

  final TextEditingController? _controller;
  final String hint;
  final Widget? trailing;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final bool enable;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextFormField(
        controller: _controller,
        scrollPadding: const EdgeInsets.only(bottom: 50),
        decoration: InputDecoration(
          suffixIcon: trailing,
          prefixIcon: prefixIcon,
          // border: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1.2, color: Color(0xFF818181)),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.2, color: Color.fromARGB(255, 83, 83, 83)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 82, 81, 81),
              // color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintText: hint,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.2, color: Color.fromARGB(255, 53, 53, 53)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabled: enable,
          hintStyle: const TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 15,
            fontFamily: AssetFonts.inter,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: AssetFonts.inter,
          fontWeight: FontWeight.w400,
        ),
        textInputAction: textInputAction,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        keyboardType: keyboardType,
        obscureText: isObscure,
      ),
    );
  }
}
