import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';

class AppResponsiveWidgets extends StatelessWidget {
  const AppResponsiveWidgets({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  //* widget for desktop
  final Widget desktop;

  //* widgets for tablet
  final Widget tablet;

  //*widget for mobile
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= TSizes.desktopScreenSize) {
          return desktop;
        } else if (constraints.maxWidth < TSizes.desktopScreenSize &&
            constraints.maxWidth >= TSizes.tabletScreenSize) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
