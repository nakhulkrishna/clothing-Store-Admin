import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/create_brands/widgets/create_brand_form.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class EditBrandsScreenMobile extends StatelessWidget {
  const EditBrandsScreenMobile({super.key,required this.brand});
  final Brandmodel brand;
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
                heading: "Update Brands",
                breadcrumitem: [Routes.categorys, "Update Brands"],
                returnToPreviousScreen: true,
              ),

              CreateBrandForm(),
            ],
          ),
        ),
      ),
    );
  }
}
