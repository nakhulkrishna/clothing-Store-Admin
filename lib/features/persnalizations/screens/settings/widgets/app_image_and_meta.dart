import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';

class AppProfileImageAndMeta extends StatelessWidget {
  const AppProfileImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              TImageUploader(
                imageType: ImageType.asset,
                image: TImages.user,
                right: 10,
                bottom: 20,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Coding with T',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text('support@thestyledclub.com'),
              SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ],
      ),
    );
  }
}
