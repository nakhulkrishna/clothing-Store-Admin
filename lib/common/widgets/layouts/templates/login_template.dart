import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/styles/spacing_styles.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';

class LoginTemeplet extends StatelessWidget {
  const LoginTemeplet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            ),
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: child,
          ),
        ),
      ),
    );
  }
}
