import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/responsive_screens.dart/custome_tablet_screen.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/responsive_screens.dart/customer_desk_top_screen.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/responsive_screens.dart/customer_mobile_screen.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: CustomerDeskTopScreen(),
      mobile: CustomerMobileScreen(),
      tablet: CustomeTabletScreen(),
    );
  }
}
