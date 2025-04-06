import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/retry.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/media/models/products_veriation_model.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/edit_products_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/products_variations_controller.dart';

class ProductsVaritaions extends StatelessWidget {
  const ProductsVaritaions({super.key});

  @override
  Widget build(BuildContext context) {
    final variationController = ProductsVariationsController.instance;

    return Obx(
      () =>
          EditProductController.instance.productType.value ==
                  ProductType.variable
              ? TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products Varitaions",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed:
                              () =>
                                  variationController.removeVariations(context),
                          child: Text("Remove variations"),
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    if (variationController.productVartions.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final variation =
                              variationController.productVartions[index];

                          return _buildVariationsTile(
                            context,
                            index,
                            variation,
                            variationController,
                          );
                        },
                        separatorBuilder:
                            (_, __) => SizedBox(height: TSizes.spaceBtwItems),
                        itemCount: variationController.productVartions.length,
                      ),

                    _buildVariationsMessages(),
                  ],
                ),
              )
              : SizedBox.shrink(),
    );
  }

  Widget _buildVariationsTile(
    BuildContext context,
    int index,
    ProductsVeriationModel variation,
    ProductsVariationsController variationController,
  ) {
    return ExpansionTile(
      title: Text(
        variation.attributesValues.entries
            .map((entry) => '${entry.key}: ${entry.value}')
            .join(),
      ),
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      children: [
        Obx(
          () => TImageUploader(
            imageType:
                variation.image.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
            image:
                variation.image.isNotEmpty
                    ? variation.image.value
                    : TImages.defaultImage,
            onIconButtonPressed:
                () => ProductImagesController.instance.selectVariationImage(
                  variation,
                ),
            left: null,
            right: 0,
          ),
        ),
        SizedBox(height: TSizes.spaceBtwInputFields),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                controller:
                    variationController.stockControllerLIst[index][variation],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText: "Stock",
                  hintText: "Add Stock, only number are allowed",
                ),
              ),
            ),

            SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller:
                    variationController.priceControllerLIst[index][variation],
                onChanged: (value) => variation.price = double.parse(value),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Price with, up-to 2 decimals",
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: TSizes.spaceBtwInputFields),

        TextFormField(
          onChanged: (value) => variation.description = value,
          controller:
              variationController.descriptionControllerLIst[index][variation],
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Add description of this veriations...',
          ),
        ),
        SizedBox(width: TSizes.spaceBtwInputFields),
      ],
    );
  }

  _buildVariationsMessages() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              imageType: ImageType.asset,
              image: TImages.defaultVariationImageIcon,
              width: 200,
              height: 200,
            ),
          ],
        ),
        SizedBox(width: TSizes.spaceBtwInputFields),
        Text("There are no variations added for this product"),
      ],
    );
  }
}
