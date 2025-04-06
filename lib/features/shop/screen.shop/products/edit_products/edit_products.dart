import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_tablet.dart';

class EditProducts extends StatelessWidget {
  const EditProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: EditProductsDeskTop(),
      mobile: EditProductsMobile(),
      tablet: EditProductsTablet(),
    );
  }
}
