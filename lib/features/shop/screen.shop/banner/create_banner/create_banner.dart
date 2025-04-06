import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/reposnive_screens.dart/create_banner_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/reposnive_screens.dart/create_banner_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/create_banner/reposnive_screens.dart/create_banner_tablet.dart';

class CreateBanner extends StatelessWidget {
  const CreateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: CreateBannerDesktop(),
      mobile: CreateBannerMobile(),
      tablet: CreateBannerTablet(),
    );
  }
}
