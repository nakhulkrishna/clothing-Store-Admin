import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/widgets/create_banner_form.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class EditBannerTablet extends StatelessWidget {
  const EditBannerTablet({super.key, required this.banner});
final BannerModel banner;
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
                heading: "Edit Banner",
                breadcrumitem: [Routes.categorys, "Edit Banner"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              EditBannerForm(bannerModel: banner,),
            ],
          ),
        ),
      ),
    );
  }
}
