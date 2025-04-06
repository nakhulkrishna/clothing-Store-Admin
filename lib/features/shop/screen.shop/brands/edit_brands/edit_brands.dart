import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/edit_brands/responsive_screen/edit_brands_screen_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/edit_brands/responsive_screen/edit_brands_screen_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/edit_brands/responsive_screen/edit_brands_screen_tablet.dart';

class EditBrands extends StatelessWidget {
  const EditBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return SiteLayout(
      desktop: EditBrandsScreenDeskTop(brand: brand),
      tablet: EditBrandsScreenTablet(brand: brand),
      mobile: EditBrandsScreenMobile(brand: brand),
    );
  }
}
