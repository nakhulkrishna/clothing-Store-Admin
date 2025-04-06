import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/produtst_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/table/product_table.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class AllproductsDesktop extends StatelessWidget {
  const AllproductsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                heading: "Products",
                breadcrumitem: ["Products"],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Obx(() {
                if (controller.isLoading.value) return TLoaderAnimation();

                return TRoundedContainer(
                  child: Column(
                    children: [
                      TableHeader(
                        searchOnchanged:
                            (query) => controller.seacrhQuery(query),
                        buttonText: "Add Products",
                        onPressed: () => Get.toNamed(Routes.createProducts),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      ProductTable(),
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
