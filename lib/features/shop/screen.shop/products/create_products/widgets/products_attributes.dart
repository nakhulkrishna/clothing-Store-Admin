import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/create_product_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_attributes_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_variations_controller.dart';

class ProductsAttributes extends StatelessWidget {
  const ProductsAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    final attributesController = Get.put(ProductsAttributesController());
    final variationsController = Get.put(ProductsVariationsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return controller.productType.value == ProductType.single
              ? Column(
                children: [
                  Divider(color: TColors.primaryBackground),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              )
              : SizedBox();
        }),

        Text(
          'Add Products Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        Form(
          key: attributesController.attributesFormkey,
          child:
              TDeviceUtils.isDesktopScreen(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildAttributesName(attributesController),
                      ),
                      SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(
                        flex: 2,
                        child: _buildAttributesTextFileds(attributesController),
                      ),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesButton(attributesController),
                    ],
                  )
                  : Column(
                    children: [
                      _buildAttributesName(attributesController),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesTextFileds(attributesController),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesButton(attributesController),
                    ],
                  ),
        ),

        SizedBox(height: TSizes.spaceBtwSections),

        Text(
          "All Attributes",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(
            () =>
                attributesController.productsAttributes.isNotEmpty
                    ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, Index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: TColors.white,
                            borderRadius: BorderRadius.circular(
                              TSizes.borderRadiusLg,
                            ),
                          ),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed:
                                  () => attributesController.removeAttributes(
                                    Index,
                                    context,
                                  ),
                              icon: Icon(Iconsax.trash, color: TColors.error),
                            ),
                            title: Text(
                              attributesController
                                      .productsAttributes[Index]
                                      .name ??
                                  "",
                            ),
                            subtitle: Text(
                              attributesController
                                  .productsAttributes[Index]
                                  .values!
                                  .map((e) => e.trim())
                                  .toString(),
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (_, __) => SizedBox(height: TSizes.spaceBtwItems),
                      itemCount: attributesController.productsAttributes.length,
                    )
                    : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TRoundedImage(
                              width: 150,
                              height: 80,
                              imageType: ImageType.asset,
                              image: TImages.defaultAttributeColorsImageIcon,
                            ),
                            SizedBox(height: TSizes.spaceBtwItems),
                            Text(
                              "There are no attributes added for this products",
                            ),
                          ],
                        ),
                      ],
                    ),
          ),
          // child: Column(
          //   children: [buildAtrributeLits(context), buildEmptyAttribuets()],
          // ),
        ),

        SizedBox(height: TSizes.spaceBtwSections),

        Obx(
          () =>
              controller.productType.value == ProductType.variable &&
                      variationsController.productVartions.isEmpty
                  ? Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton.icon(
                        icon: Icon(Iconsax.activity),
                        onPressed:
                            () => variationsController
                                .generateVariationsConfirmation(context),
                        label: Text("Generate Variations"),
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
        ),
      ],
    );
  }

  TextFormField _buildAttributesName(ProductsAttributesController controller) {
    return TextFormField(
      controller: controller.attributesName,
      validator:
          (value) => TValidator.validateEmptyText("Attributes Name", value),
      decoration: InputDecoration(
        labelText: "Attributes",
        hintText: "Colors, Size, Material",
      ),
    );
  }

  SizedBox _buildAttributesTextFileds(ProductsAttributesController cotroller) {
    return SizedBox(
      height: 80,

      child: TextFormField(
        controller: cotroller.attributes,
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator:
            (value) => TValidator.validateEmptyText("Attributes Field", value),
        decoration: InputDecoration(
          labelText: 'Attributes',
          hintText:
              "Add attributes separated by | Example: Green | Blue | Yellow",
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  SizedBox _buildAttributesButton(ProductsAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttributes(),
        label: Text("Add"),
        icon: Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.black,
          backgroundColor: TColors.secondary,
          side: BorderSide(color: TColors.secondary),
        ),
      ),
    );
  }

  buildAtrributeLits(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: TColors.white,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: Text("Color"),
            subtitle: Text("Green , Orange,Pink"),
            trailing: IconButton(onPressed: () {}, icon: Icon(Iconsax.trash)),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: TSizes.spaceBtwItems),
      itemCount: 3,
    );
  }

  buildEmptyAttribuets() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
              height: 80,
              width: 150,
            ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text("There are no attributes addedd for this products"),
      ],
    );
  }
}
