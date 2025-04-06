import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/models/banner_model.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/edit_banner/reposnive_screens.dart/edit_banner_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/edit_banner/reposnive_screens.dart/edit_banner_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/edit_banner/reposnive_screens.dart/edit_banner_tablet.dart';

class EditBanner extends StatelessWidget {
  EditBanner({super.key});
  final banner = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: EditBannerDesktop(banner: banner),
      mobile: EditBannerMobile(banner: banner),
      tablet: EditBannerTablet(banner: banner),
    );
  }
}
