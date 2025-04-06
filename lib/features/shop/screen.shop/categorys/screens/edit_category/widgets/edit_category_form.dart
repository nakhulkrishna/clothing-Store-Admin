import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/edit_categories_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoriesController());
    editController.init(categoryModel);
    final categorysController = Get.put(CategorysController());

    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.sm),

            Text(
              "Update Category",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              controller: editController.name,
              decoration: InputDecoration(
                labelText: 'Category Name',
                prefix: Icon(Iconsax.category),
              ),
              validator: (value) => TValidator.validateEmptyText('Name', value),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => DropdownButtonFormField<CategoryModel>(
                items:
                    categorysController.allItems
                        .map(
                          (items) => DropdownMenuItem(
                            value: items,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(items.name)],
                            ),
                          ),
                        )
                        .toList(),
                onChanged:
                    (onChanged) =>
                        editController.selectedParent.value = onChanged!,
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
                    editController.imageUrl.value.isNotEmpty
                        ? editController.imageUrl.value
                        : TImages.defaultImage,
                imageType:
                    editController.imageUrl.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => editController.pickImages(),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            Obx(
              () => CheckboxMenuButton(
                value: editController.isFeatured.value,
                onChanged:
                    (value) => editController.isFeatured.value = value ?? false,
                child: Text("Featured"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => editController.updatedCategorys(categoryModel),
                child: Text("Update"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
