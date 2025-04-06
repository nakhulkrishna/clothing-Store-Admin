import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/constants/text_strings.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/headers/headers.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/login_template.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/login/widgets/login_form.dart';
import 'package:thestyldclubadmin/features/authentication/screens.authentication/reset_password/widgets/reset_password_widget.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class ResetPasswordDesktopTablet extends StatelessWidget {
  const ResetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? "";
    return LoginTemeplet(child: RestPasswordWidget());
  }
}
