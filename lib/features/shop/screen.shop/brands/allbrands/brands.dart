import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/reponsive_screens/brands_screen_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/reponsive_screens/brands_screen_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/brands/allbrands/reponsive_screens/brands_screen_tablet.dart';

class BrandsScreen extends StatelessWidget {
  BrandsScreen({super.key});
  final brandmodel = Brandmodel(name: "name", id: "id", image: "image");
  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: BrandsScreenDeskTop(brandmodel: brandmodel),
      mobile: BrandsScreenMobile(),
      tablet: BrandsScreenTablet(),
    );
  }
}
