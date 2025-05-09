import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/widgets/banners_table.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class AllBannerDeskTop extends StatelessWidget {
  const AllBannerDeskTop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BreadcrumsWithHeading(
                heading: "Banners",
                breadcrumitem: ["Banners"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Obx(() {
                if (controller.isLoading.value) return TLoaderAnimation();
                return TRoundedContainer(
                  child: Column(
                    children: [
                      TableHeader(
                        buttonText: 'Create New Banner',
                        onPressed: () => Get.toNamed(Routes.createBanner),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      BannersTable(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
