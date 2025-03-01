
import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/modules/layout/cubit/home_layout_cubit.dart';

import '../constants/app_colors.dart';

Future<void> showSuccessDialog(BuildContext context, String message,VoidCallback onOkPressed)async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(12)),
        title:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 60),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: ()  {
        Navigator.pop(context);
              HomeLayoutCubit.get(context).changeIndex(0);

              onOkPressed.call();},
            child: const Text("OK", style: TextStyle(color: AppColors.primaryColor,fontSize: 18)),
          ),
        ],
      );
    },
  );
}
