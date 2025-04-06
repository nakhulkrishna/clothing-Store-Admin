import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/responsive_screen/create_products_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/responsive_screen/create_products_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/create_products/responsive_screen/create_products_tablet.dart';

class CreateProducts extends StatelessWidget {
  const CreateProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: CreateProductsDeskTop(),
      mobile: CreateProductsMobile(),
      tablet: CreateProductsTablet(),
    );
  }
}
