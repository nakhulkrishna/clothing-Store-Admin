import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/product_titile_and_description.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_additinalImages.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_attributes.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_bottom_navigation.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_categorys.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_stock_and_pricing.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_thumbnail.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_type_widgets.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_varitaions.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_visibility.dart';

import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/widgets/products_brands.dart';

import 'package:thestyldclubadmin/routes/routes.dart';

class CreateProductsDeskTop extends StatelessWidget {
  const CreateProductsDeskTop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    return Scaffold(
      bottomNavigationBar: ProductsBottomNavigation(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                returnToPreviousScreen: true,
                heading: "Create Products",
                breadcrumitem: [Routes.products],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitileAndDescription(),
                        SizedBox(height: TSizes.spaceBtwSections),
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stock & Pricing",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(height: TSizes.spaceBtwSections),
                              ProductsTypeWidgets(),
                              SizedBox(height: TSizes.spaceBtwSections),

                              ProductsStockAndPricing(),
                              SizedBox(height: TSizes.spaceBtwSections),
                              ProductsAttributes(),
                              SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        SizedBox(height: TSizes.spaceBtwSections),
                        ProductsVaritaions(),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwSections),
                  Expanded(
                    child: Column(
                      children: [
                        ProductsThumbnail(),
                        SizedBox(height: TSizes.spaceBtwSections),
                        TRoundedContainer(
                          child: Column(
                            children: [
                              Text(
                                "All Products Images",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(height: TSizes.spaceBtwItems),
                              ProductsAdditinalimages(
                                additionalProdutsImagesUrls:
                                    controller.additinalProductsimagesUrls,
                                ontapAddImages:
                                    () =>
                                        controller
                                            .selectedMultipleProductsImages(),
                                onTapRemoveImages:
                                    (index) => controller.removeImage(index),
                              ),
                              SizedBox(height: TSizes.spaceBtwItems),
                              ProductsBrands(),
                              SizedBox(height: TSizes.spaceBtwItems),
                              ProductsCategorys(),
                              SizedBox(height: TSizes.spaceBtwItems),
                              ProductsVisibilityWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
