import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/responsive_screens/all_products_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/responsive_screens/all_products_tablet.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/all_products/responsive_screens/allproducts_desktop.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: AllproductsDesktop(),
      mobile: AllProductsMobile(),
      tablet: AllProductsTablet(),
    );
  }
}
