import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_uploader.dart';

class ProductsAdditinalimages extends StatelessWidget {
  const ProductsAdditinalimages({
    super.key,
    required this.additionalProdutsImagesUrls,
    this.ontapAddImages,
    this.onTapRemoveImages,
  });

  final RxList<String> additionalProdutsImagesUrls;
  final void Function()? ontapAddImages;
  final void Function(int index)? onTapRemoveImages;

  @override
  Widget build(BuildContext context) {
    print("images  ${additionalProdutsImagesUrls}");
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: ontapAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      Text("Add Additinal Products Images"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(height: 80, child: _uploadImagesOrEmpty()),
                ),
                SizedBox(width: TSizes.spaceBtwItems / 2),
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  onTap: ontapAddImages,
                  child: Center(child: Icon(Iconsax.add)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _uploadImagesOrEmpty() {
    return _uploadedImages();
  }

  Widget emptyList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder:
          (context, index) => TRoundedContainer(
            backgroundColor: TColors.primaryBackground,
            width: 80,
            height: 80,
          ),
      separatorBuilder:
          (context, index) => SizedBox(width: TSizes.spaceBtwItems / 2),
      itemCount: 6,
    );
  }

  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) {
        final images = additionalProdutsImagesUrls[index];
        return TImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: images,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapRemoveImages!(index),
        );
      },
      separatorBuilder:
          (context, index) => SizedBox(width: TSizes.spaceBtwItems / 2),
      itemCount: additionalProdutsImagesUrls.length,
    );
  }
}
