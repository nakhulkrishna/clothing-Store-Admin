import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/images/image_pop.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/animation_loader.dart';
import 'package:thestyldclubadmin/common/widgets/loaders/loader_animation.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  bool loadedPreviousSelection = false;

  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alredySelectedUrls,
    this.onImageSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alredySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;
  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Media image header
          //Folder DropDown
          //Folders Dropdown
          Row(
            children: [
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(width: TSizes.spaceBtwItems),

              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
              if (allowSelection) _buildAddSelectedImagesButton(),
            ],
          ),

          SizedBox(height: TSizes.spaceBtwSections),
          Obx(() {
            List<ImageModel> images = _getSelectedFolderImages(controller);

            if (!loadedPreviousSelection) {
              if (alredySelectedUrls != null &&
                  alredySelectedUrls!.isNotEmpty) {
                final selectedUrlSet = Set<String>.from(alredySelectedUrls!);
                for (var image in images) {
                  image.isSelected.value = selectedUrlSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }
            if (controller.loading.value && images.isEmpty)
              return const TLoaderAnimation();

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems / 2,
                  children:
                      images
                          .map(
                            (images) => GestureDetector(
                              onTap: () => Get.dialog(ImagePop(image: images)),
                              child: SizedBox(
                                width: 140,
                                height: 180,

                                child: Column(
                                  children: [
                                    allowSelection
                                        ? _buildSimpleListWithCheckbox(images)
                                        : _buildSimpleList(images),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: TSizes.sm,
                                        ),
                                        child: Text(
                                          images.filename,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),

                if (!controller.loading.value)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: Text("Load More"),
                            icon: Icon(Iconsax.arrow_down),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];

    if (controller.selectedPath.value == MediaCategory.banners) {
      images =
          controller.allBannerImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images =
          controller.allBrandsImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images =
          controller.allCategoryImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images =
          controller.allProductsImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images =
          controller.alluserImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _buildSimpleList(ImageModel images) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: images.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }

  _buildSimpleListWithCheckbox(ImageModel images) {
    return Stack(
      children: [
        TRoundedImage(
          width: 140,
          height: 140,
          padding: TSizes.sm,
          image: images.url,
          imageType: ImageType.network,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),

        Positioned(
          top: TSizes.md,
          right: TSizes.md,
          child: Obx(
            () => Checkbox(
              value: images.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  images.isSelected.value = selected;

                  if (selected) {
                    if (!allowMultipleSelection) {
                      for (var otherImages in selectedImages) {
                        if (otherImages != null) {
                          otherImages.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(images);
                  } else {
                    selectedImages.remove(images);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            icon: Icon(Iconsax.close_circle),
            label: Text("Close"),
          ),
        ),

        const SizedBox(width: TSizes.spaceBtwItems),

        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: Text("Add"),
            icon: Icon(Iconsax.image),
          ),
        ),
      ],
    );
  }
}
