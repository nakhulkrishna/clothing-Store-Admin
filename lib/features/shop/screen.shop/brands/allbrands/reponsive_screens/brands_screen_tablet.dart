import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/table/brand_table.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class BrandsScreenTablet extends StatelessWidget {
  const BrandsScreenTablet({super.key});

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
                heading: "Brands",
                breadcrumitem: ["Brands"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: "Create New Brands",
                      onPressed: () => Get.toNamed(Routes.createBrands),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    BrandTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
