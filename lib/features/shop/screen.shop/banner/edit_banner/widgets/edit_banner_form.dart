import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/edit_banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.bannerModel});
  final BannerModel bannerModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(bannerModel);
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
              "Edit New Banner",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: TSizes.spaceBtwSections),

            Column(
              children: [
                Obx(
                  () => TRoundedImage(
                    width: 400,
                    height: 200,
                    imageType: ImageType.network,
                    backgroundColor: TColors.primaryBackground,
                    image:
                        controller.imageurl.value.isNotEmpty
                            ? controller.imageurl.value
                            : TImages.defaultImage,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                TextButton(
                  onPressed: () => controller.pickImage(),
                  child: Text('Select Image'),
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            Text(
              'Make your Banner Active or InActive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged:
                    (value) => controller.isActive.value = value ?? false,
                child: Text("Active"),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwInputFields),

            DropdownButton<String>(
              items: [
                DropdownMenuItem(value: "String", child: Text("Home")),
                DropdownMenuItem(value: "Search", child: Text("Search")),
              ],
              onChanged: (String? value) {},
              value: "Search",
            ),

            SizedBox(height: TSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    () => controller.EditBannerControllerBanner(bannerModel),
                child: Text("Edit"),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
