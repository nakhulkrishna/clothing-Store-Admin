import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/widgets/app_image_and_meta.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/widgets/app_settings_form.dart';

class SettingsDeskTop extends StatelessWidget {
  const SettingsDeskTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                heading: "Profile",
                breadcrumitem: ["Profile"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: AppProfileImageAndMeta()),
                  SizedBox(width: TSizes.spaceBtwSections),
                  Expanded(flex: 2, child: AppSettingsFrom()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}