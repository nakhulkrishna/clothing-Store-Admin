import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/media/controller/media_controller.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/media_content.dart';
import 'package:thestyldclubadmin/features/media/screens.media/widgets/media_uploader.dart';

class MediaScreenDeskTop extends StatelessWidget {
  const MediaScreenDeskTop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Headers
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BreadcrumsWithHeading(heading: 'Media', breadcrumitem: []),
                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,

                    child: ElevatedButton.icon(
                      icon: Icon(Iconsax.cloud_add),
                      onPressed:
                          () =>
                              controller.showImagesUploaderSections.value =
                                  !controller.showImagesUploaderSections.value,
                      label: Text("Upload images"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              //upload Area
              MediaUploader(), SizedBox(height: TSizes.spaceBtwSections),
              //Media
              MediaContent(
                allowSelection: false,
                allowMultipleSelection: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
