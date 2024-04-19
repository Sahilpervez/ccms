import 'package:flutter/material.dart';

import '../../../../res/assets.dart';

class AuthFormField extends StatefulWidget {
  const AuthFormField({
    super.key,
    required this.ctx,
    required this.controller,
    required this.title,
    this.hintText = "",
    this.isPassword = false,
    this.bottomSpacing = 0,
  });

  final controller;

  final String title;
  final String hintText;
  final bool isPassword;
  final double bottomSpacing;
  final BuildContext ctx;
  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool _passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = (widget.isPassword)?false:true;
    super.initState();
  }

  void _toggleVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _passwordVisible = (widget.isPassword)? false: true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: AssetFonts.roboto,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 9,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(240, 245, 250, 1),
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            obscureText: (_passwordVisible)?false:true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(160, 165, 186, 1),
              ),
              suffixIcon: (widget.isPassword)?InkWell(
                onTap: () {
                  _toggleVisible();
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: (_passwordVisible)
                      ? Colors.blueAccent
                      : const Color.fromRGBO(
                      160, 165, 186, 1),
                ),
              ):null,
            ),
            onTapOutside: (val){
              FocusScope.of(widget.ctx).unfocus();
            },
            onFieldSubmitted: (val){},
          ),
        ),
        SizedBox(
          height: widget.bottomSpacing,
        ),
      ],
    );
  }
}