import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/responsive_screens/all_banner_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/responsive_screens/all_banner_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/responsive_screens/all_bnner_tablet.dart';

class AllBanners extends StatelessWidget {
  const AllBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop:AllBannerDeskTop(),
      mobile: AllBannerMobile(),
      tablet: AllBnnerTablet(),
    );
  }
}
