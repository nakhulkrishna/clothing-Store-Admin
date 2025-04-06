import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';
import 'package:thestyldclubadmin/common/widgets/shimmers/shimmer.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/create_categories_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class CreateCategorysForm extends StatelessWidget {
  const CreateCategorysForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoriesController());
    final categoriesController = Get.put(CategorysController());
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.sm),

            Text(
              "Create New Category",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              controller: createController.name,
              decoration: InputDecoration(
                labelText: 'Category Name',
                prefix: Icon(Iconsax.category),
              ),
              validator: (value) => TValidator.validateEmptyText('Name', value),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            // CATEGRIRES DROPDOWN
            Obx(
              () =>
                  categoriesController.isLoading.value
                      ? TShimmerEffect(width: double.infinity, height: 55)
                      : DropdownButtonFormField(
                        items:
                            categoriesController.allItems
                                .map(
                                  (items) => DropdownMenuItem(
                                    value: items,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [Text(items.name)],
                                    ),
                                  ),
                                )
                                .toList(),

                        onChanged:
                            (newValue) =>
                                createController.selectedParent.value =
                                    newValue!,
                        decoration: InputDecoration(
                          hintText: 'Parent category',
                          labelText: 'Parent category',
                          prefixIcon: Icon(Iconsax.bezier),
                        ),
                      ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields * 2),
            Obx(
              () => TImageUploader(
                width: 80,
                height: 80,
                image:
                    createController.imageUrl.value.isNotEmpty
                        ? createController.imageUrl.value
                        : TImages.defaultImage,
                imageType:
                    createController.imageUrl.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => createController.pickImages(),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            Obx(
              () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged:
                    (value) =>
                        createController.isFeatured.value = value ?? false,
                child: Text("featured"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => createController.createcategories(),
                child: Text("Create"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
