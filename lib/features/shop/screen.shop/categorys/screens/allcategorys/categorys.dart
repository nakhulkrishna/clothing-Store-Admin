import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/responsive_screen/category_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/responsive_screen/categorys_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/responsive_screen/categorys_tablet.dart';

class CategorysScreen extends StatelessWidget {
  const CategorysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryModel(
      name: "name",
      id: "id",
      image: "image",
     
    );
    return SiteLayout(
      desktop: CategoryDeskTop(categorys: categories),
      mobile: CategorysMobile(categorys: categories),
      tablet: CategorysTablet(categorys: categories),
    );
  }
}
