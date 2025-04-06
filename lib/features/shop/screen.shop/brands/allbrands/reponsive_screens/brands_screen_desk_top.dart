import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/table/brand_table.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class BrandsScreenDeskTop extends StatelessWidget {
  const BrandsScreenDeskTop({super.key, required this.brandmodel});

  // BRAND MODEL
  final Brandmodel brandmodel;

  @override
  Widget build(BuildContext context) {
    //CONTROLLER
    final controller = Get.put(BrandController());
    final categoryController = Get.put(CategorysController());

    categoryController.onInit();
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
                    if (!TDeviceUtils.isMobileScreen(context))
                      TableHeader(
                        searchOnchanged:
                            (query) => controller.seacrhQuery(query),
                        buttonText: "Create New Brands",
                        onPressed: () => Get.toNamed(Routes.createBrands),
                      ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return BrandTable();
                    }),
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
