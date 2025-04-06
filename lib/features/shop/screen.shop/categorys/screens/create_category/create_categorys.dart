import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/create_category/responsive_screens/create_categirys_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/create_category/responsive_screens/create_categorys_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/create_category/responsive_screens/create_categorys_tablets.dart';

class CreateCategorys extends StatelessWidget {
  const CreateCategorys({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: CreateCategirysDesktop(),
      mobile: CreateCategorysMobile(),
      tablet: CreateCategorysTablets(),
    );
  }
}
