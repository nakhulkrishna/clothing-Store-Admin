import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/widgets/create_banner_form.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CreateBannerMobile extends StatelessWidget {
  const CreateBannerMobile({super.key});

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
                returnToPreviousScreen: true,
                heading: "Create Banner",
                breadcrumitem: [Routes.categorys, "Create Banner"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
