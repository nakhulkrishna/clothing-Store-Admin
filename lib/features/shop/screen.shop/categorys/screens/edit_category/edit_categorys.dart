import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/edit_category/responsive_screens/edit_categorys_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/edit_category/responsive_screens/edit_categorys_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/edit_category/responsive_screens/edit_categorys_tablets.dart';

class EditCategorys extends StatelessWidget {
  const EditCategorys({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return SiteLayout(
      desktop: EditCategorysDesktop(categoryModel: category),
      mobile: EditCategorysMobile(categoryModel: category),
      tablet: EditCategorysTablets(categoryModel: category),
    );
  }
}
