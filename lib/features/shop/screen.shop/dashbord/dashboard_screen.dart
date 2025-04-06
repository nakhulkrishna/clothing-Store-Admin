import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/responsive_layouts/dashboard_desktop.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/responsive_layouts/dashboard_mobile.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/responsive_layouts/dashboard_tablet.dart'
    show DashboardTablet;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: DashboardDesktop(),
      mobile: DashboardMobile(),
      tablet: DashboardTablet(),
    );
  }
}
