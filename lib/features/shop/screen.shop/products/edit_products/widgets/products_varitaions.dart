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

class ProductsVaritaions extends StatelessWidget {
  const ProductsVaritaions({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
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
              TextButton(onPressed: () {}, child: Text("Remove variations")),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _buildVariationsTile();
            },
            separatorBuilder: (_, __) => SizedBox(height: TSizes.spaceBtwItems),
            itemCount: 2,
          ),

          _buildVariationsMessages(),
        ],
      ),
    );
  }

  Widget _buildVariationsTile() {
    return ExpansionTile(
      title: Text("Color: Orange"),
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
            imageType: ImageType.asset,
            image: TImages.defaultImage,
            onIconButtonPressed: () {},
            left: null,
            right: 0,
          ),
        ),
        SizedBox(height: TSizes.spaceBtwInputFields),

        Row(
          children: [
            Expanded(
              child: TextFormField(
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
