import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/constants/text_strings.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class RestPasswordWidget extends StatelessWidget {
  const RestPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['eamil'] ?? "";
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(Routes.login),
              icon: Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Image(
          image: AssetImage(TImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text(
          textAlign: TextAlign.center,
          TTexts.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.login),
            child: Text(TTexts.done),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.login),
            child: Text(TTexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
