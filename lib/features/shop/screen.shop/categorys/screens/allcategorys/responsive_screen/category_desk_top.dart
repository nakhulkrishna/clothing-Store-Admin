import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/table/data_table.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/table_header.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CategoryDeskTop extends StatelessWidget {
  const CategoryDeskTop({super.key, required this.categorys});
  final CategoryModel categorys;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategorysController());
    

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                heading: "Categorys",
                breadcrumitem: ["Categorys"],
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Create New Categorys',
                      onPressed: () => Get.toNamed(Routes.createCategories),
                      searchController: controller.searchTextController,
                      searchOnchanged: (query) => controller.seacrhQuery(query),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      if (controller.isLoading.value) return TLoaderAnimation();
                      return CategorysTable();
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
