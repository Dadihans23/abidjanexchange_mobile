import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25 , vertical: 25),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("lib/images/logo.jpg", width: 200, height: 200),

              ],
            )
          ],
        ),
      )
    );
  }
}