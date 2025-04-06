import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/features/media/models/image_model.dart';

import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/folder_dropdown.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () =>
          controller.showImagesUploaderSections.value
              ? Column(
                children: [
                  // Drag And Drop Area
                  TRoundedContainer(
                    showBorder: true,
                    height: 250,
                    borderColor: TColors.borderPrimary,
                    backgroundColor: TColors.primaryBackground,
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              DropzoneView(
                                mime: ['image/jpeg', 'image/png'],
                                cursor: CursorType.Default,
                                operation: DragOperation.copy,
                                onLoaded: () => print('zone loaded'),
                                onError: (value) => print('zone error $value'),
                                onHover: () => print('zone hovered'),
                                onLeave: () => print('zone left'),
                                onCreated:
                                    (ctrl) =>
                                        controller.dropzoneViewController =
                                            ctrl,
                                // ondrop file
                                onDropFile: (file) async {
                                  if (file is DropzoneFileInterface) {
                                    final bytes = await controller
                                        .dropzoneViewController
                                        .getFileData(file);

                                    final image = ImageModel(
                                      url: '',
                                      folder: '',
                                      filename: file.type,
                                      dropzoneFile: file,
                                      localimateToDisplay: Uint8List.fromList(
                                        bytes,
                                      ),
                                    );
                                    controller.selectedImagesToupload.add(
                                      image,
                                    );
                                  } else if (file is String) {
                                    log("Zone drop:$file");
                                  } else {
                                    log(
                                      "Zone unknown type:${file.runtimeType}",
                                    );
                                  }
                                },
                                onDropInvalid:
                                    (value) =>
                                        print('zone invalid MIME: $value'),
                                onDropMultiple: (value) async {
                                  print('zone drop multiple $value');
                                },
                              ),

                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    TImages.defaultMultiImageIcon,
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  Text("Drag and Drop Images here"),
                                  SizedBox(height: TSizes.spaceBtwItems),
                                  OutlinedButton(
                                    onPressed:
                                        () => controller.selectlocalImage(),
                                    child: Text("Select Images"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //Localy Selected Images
                  if (controller.selectedImagesToupload.isNotEmpty)
                    TRoundedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Folders Dropdown
                              Row(
                               
                                children: [
                                  Text(
                                    'Select Folder',
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                  ),
                                  SizedBox(width: TSizes.spaceBtwItems),

                                  MediaFolderDropdown(
                                    onChanged: (MediaCategory? newValue) {
                                      if (newValue != null) {
                                        controller.selectedPath.value =
                                            newValue;
                                      }
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  TextButton(
                                    onPressed:
                                        () =>
                                            controller.selectedImagesToupload
                                                .clear(),
                                    child: Text("Remove All"),
                                  ),
                                  SizedBox(width: TSizes.spaceBtwItems),
                                  TDeviceUtils.isMobileScreen(context)
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                          onPressed:
                                              () =>
                                                  controller
                                                      .uploadImagesConfirmartion(),
                                          child: Text('Upload'),
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),

                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: TSizes.spaceBtwItems / 2,
                            runSpacing: TSizes.spaceBtwItems / 2,
                            children:
                                controller.selectedImagesToupload
                                    .where(
                                      (images) =>
                                          images.localimateToDisplay != null,
                                    )
                                    .map(
                                      (element) => TRoundedImage(
                                        imageType: ImageType.memory,
                                        width: 90,
                                        height: 90,
                                        memoryImage:
                                            element.localimateToDisplay,
                                        backgroundColor:
                                            TColors.primaryBackground,
                                      ),
                                    )
                                    .toList(),
                          ),

                          const SizedBox(height: TSizes.spaceBtwSections),

                          TDeviceUtils.isMobileScreen(context)
                              ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      () =>
                                          controller
                                              .uploadImagesConfirmartion(),
                                  child: Text('Upload'),
                                ),
                              )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                ],
              )
              : SizedBox.shrink(),
    );
  }
}
