import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/product_images_controller.dart';

class ProductsThumbnail extends StatelessWidget {
  const ProductsThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller = Get.put(
      ProductImagesController(),
    );
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Thumbnail",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => TRoundedImage(
                            imageType:
                                controller.selectedThumnailImageUrl.value ==
                                        null
                                    ? ImageType.asset
                                    : ImageType.network,
                            width: 220,
                            height: 220,
                            image:
                                controller.selectedThumnailImageUrl.value ??
                                TImages.defaultMultiImageIcon,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () => controller.selectedThumbnailImages(),
                      child: Text("Add Thumbnail"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
