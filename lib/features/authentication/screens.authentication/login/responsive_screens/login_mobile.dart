import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/widgets/login_form.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/widgets/login_header.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              LoginHeader(),
              // Form
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
