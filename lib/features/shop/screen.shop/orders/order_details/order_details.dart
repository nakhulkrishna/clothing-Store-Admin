import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/responsive_screen/order_details_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/responsive_screen/order_details_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/order_details/responsive_screen/order_details_tablet.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return SiteLayout(
      desktop: OrderDetailsDesktop(order: order),
      tablet: OrderDetailsTablet(),
      mobile: OrderDetailsMobile(),
    );
  }
}
