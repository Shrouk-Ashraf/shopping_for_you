import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';

class Toasts {
  Toasts._();

  static showErrorToast(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: AppColors.error,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: AppColors.textPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showSuccessToast(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_outlined,
                color: AppColors.success,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: AppColors.textPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
