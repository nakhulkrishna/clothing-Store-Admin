import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/responsive_screens/login_desktop_tablet.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayout(
      useLayout: false,
      desktop: LoginDesktopTabletScreen(),
      mobile: LoginMobileScreen(),
      tablet: LoginDesktopTabletScreen(),
    );
  }
}
