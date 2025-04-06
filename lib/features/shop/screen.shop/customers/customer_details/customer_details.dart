import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/authentication/models/models.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/responsive_screens/customer_details_desk_top.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/responsive_screens/customer_details_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/customer_details/responsive_screens/customer_details_tablet.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // final customer = Get.arguments;

    return SiteLayout(
      desktop: CustomerDetailsDeskTop(),
      mobile: CustomerDetailsMobile(),
      tablet: CustomerDetailsTablet(),
    );
  }
}
