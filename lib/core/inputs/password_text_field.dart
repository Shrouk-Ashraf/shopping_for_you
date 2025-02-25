import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? labelText;
  final String? Function(String?)? validator;
  final String? hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.labelText,
    this.validator,
    this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      textAlignVertical: TextAlignVertical.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: passwordVisibility,
      textInputAction: TextInputAction.done,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Password is Required';
            }
            return null;
          },
      autofillHints: const [
        AutofillHints.password,
      ],
      decoration: InputDecoration(
        errorMaxLines: 6,
        labelText: widget.labelText,
        isDense: true,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        prefixIcon: const Icon(
          Icons.password_rounded,
          size: 24,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisibility
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 24,
          ),
          onPressed: () => setState(() {
            passwordVisibility = !passwordVisibility;
          }),
        ),
      ),
    );
  }
}
