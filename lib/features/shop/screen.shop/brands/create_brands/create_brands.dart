import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/create_brands/responsive_screen/create_branda_screen_tablet.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/create_brands/responsive_screen/create_brands_screen_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/create_brands/responsive_screen/create_brands_screen_mobile.dart';

class CreateBrands extends StatelessWidget {
  const CreateBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayout(
      desktop: CreateBrandsScreenDeskTop(),
      mobile: CreateBrandsScreenMobile(),
      tablet: CreateBrandaScreenTablet(),
    );
  }
}
