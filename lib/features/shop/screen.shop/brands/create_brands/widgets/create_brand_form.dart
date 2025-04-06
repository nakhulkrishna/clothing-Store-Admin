import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/chips/rounded_choice_chips.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';
import 'package:thestyldclubadmin/features/shop/controller/brand/create_brand_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: TSizes.sm),
            Text(
              "Create New Brand",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: TSizes.spaceBtwSections),

            TextFormField(
              controller: controller.name,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwInputFields),

            Text(
              'Select categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(height: TSizes.spaceBtwInputFields / 2),

            Obx(
              () => Wrap(
                spacing: TSizes.sm,

                children:
                    CategorysController.instance.allItems
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(bottom: TSizes.sm),
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
            SizedBox(height: TSizes.spaceBtwInputFields * 2),

            Obx(
              () => TImageUploader(
                width: 80,
                height: 80,
                imageType:
                    controller.imageurl.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                image:
                    controller.imageurl.value.isNotEmpty
                        ? controller.imageurl.value
                        : TImages.defaultImage,
                onIconButtonPressed: () => controller.pickImage(),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged:
                    (value) => controller.isFeatured.value = value ?? false,
                child: Text("Featured"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createBrand(),
                child: Text('Create'),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
