import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/login_template.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/forget_password/widgets/header_and_form.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemeplet(
      child: HeaderAndForm(),
    );
  }
}
