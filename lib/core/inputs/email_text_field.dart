import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hintText,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: AppColors.primaryColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email_outlined,
          size: 24,
        ),
        labelText: 'Email',
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        isDense: true,
      ),
      autofillHints: const [
        AutofillHints.email,
      ],
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Email is Required';
        }
        return null;
      },
    );
  }
}
