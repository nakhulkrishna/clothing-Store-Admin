import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/login_template.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/widgets/login_form.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/widgets/login_header.dart';


class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemeplet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          LoginHeader(),
          // Form
          LoginForm(),
        ],
      ),
    );
  }
}
