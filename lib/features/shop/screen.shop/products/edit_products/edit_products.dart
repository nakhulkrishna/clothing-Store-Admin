import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/controller/products/edit_products_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/products/edit_products/responsive_screen/edit_products_tablet.dart';

class EditProducts extends StatelessWidget {
  const EditProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductsData(product);
    return SiteLayout(
      desktop: EditProductsDeskTop(product: product),
      mobile: EditProductsMobile(),
      tablet: EditProductsTablet(),
    );
  }
}
