import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/chips/rounded_choice_chips.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/edit_brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';

class EditBrandsForm extends StatelessWidget {
  const EditBrandsForm({super.key, required this.brand});
  final Brandmodel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());

    // Initialize only once per widget lifecycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init(brand);
    });

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),

            Text(
              "Update Brand",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Brand Name
            TextFormField(
              controller: controller.name,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Please enter brand name"
                          : null,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Select Categories
            Text(
              'Select Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            Obx(
              () => Wrap(
                spacing: TSizes.sm,
                children:
                    CategorysController.instance.allItems
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: TSizes.sm),
                            child: TChoiceChip(
                              text: e.name,
                              selected: controller.selectedCategories.contains(
                                e,
                              ),
                              onSelected:
                                  (value) => controller.toggoleSelection(e),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Image Uploader
            TImageUploader(
              width: 80,
              height: 80,
              imageType: ImageType.network,
              image: TImages.defaultImage,
              onIconButtonPressed: () => controller.pickImage(),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Featured Checkbox
            Obx(
              () => CheckboxListTile(
                value: controller.isFeatured.value,
                onChanged:
                    (value) => controller.isFeatured.value = value ?? false,
                title: const Text("Featured"),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.formkey.currentState!.validate()) {
                    controller.updateBrands(brand);
                  }
                },
                child: const Text('Update'),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
