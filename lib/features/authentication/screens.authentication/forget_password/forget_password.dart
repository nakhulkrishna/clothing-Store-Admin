import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/forget_password/responsive_screens/forget_password_mobile.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      useLayout: false,
      desktop: ForgetPasswordDesktopTablet(),
      mobile: ForgetPasswordMobile(),
      tablet: ForgetPasswordDesktopTablet(),
    );
  }
}
