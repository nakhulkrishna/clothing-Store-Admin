import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/reponsive_screen/all_order_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/reponsive_screen/all_order_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/orders/all_orders/reponsive_screen/all_order_tablet.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: AllOrderDesktop(),
      mobile: AllOrderMobile(),
      tablet: AllOrderTablet(),
    );
  }
}
