import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';

class ProductsAttributes extends StatelessWidget {
  const ProductsAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: TColors.primaryBackground),
        SizedBox(height: TSizes.spaceBtwSections),
        Text(
          'Add Products Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: TSizes.spaceBtwItems),

        Form(
          child:
              TDeviceUtils.isDesktopScreen(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributesName()),
                      SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(flex: 2, child: _buildAttributesTextFileds()),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesButton(),
                    ],
                  )
                  : Column(
                    children: [
                      _buildAttributesName(),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesTextFileds(),
                      SizedBox(width: TSizes.spaceBtwItems),
                      _buildAttributesButton(),
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
          child: Column(
            children: [buildAtrributeLits(context), buildEmptyAttribuets()],
          ),
        ),

        SizedBox(height: TSizes.spaceBtwSections),

        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              icon: Icon(Iconsax.activity),
              onPressed: () {},
              label: Text("Generate Variations"),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField _buildAttributesName() {
    return TextFormField(
      validator:
          (value) => TValidator.validateEmptyText("Attributes Name", value),
      decoration: InputDecoration(
        labelText: "Attributes",
        hintText: "Colors, Size, Material",
      ),
    );
  }

  SizedBox _buildAttributesTextFileds() {
    return SizedBox(
      height: 80,

      child: TextFormField(
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

  SizedBox _buildAttributesButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
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
