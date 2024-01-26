import 'package:flutter/material.dart';

import '../Font & Color Helper/font_&_color_helper.dart';

class AccountStatus{
  Future<void> accountStatus(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            children: [
              Icon(Icons.account_balance_rounded, color: hsPrime),
              const SizedBox(width: 10),
              const Text(
                "Account Status",
                style: TextStyle(
                  fontFamily: FontType.MontserratMedium,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: const Text(
            "Your account is currently inactive.\nPlease contact support for assistance.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: FontType.MontserratRegular,
              fontSize: 14,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog box
              },
              style: ElevatedButton.styleFrom(
                primary: hsPrime,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontFamily: FontType.MontserratMedium,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}