import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/responsive/responsive.dart';
import 'package:thestyldclubadmin/common/widgets/responsive/screen/desktop_layout.dart';
import 'package:thestyldclubadmin/common/widgets/responsive/screen/mobile_layout.dart';
import 'package:thestyldclubadmin/common/widgets/responsive/screen/tablet_layout.dart';

class SiteLayout extends StatelessWidget {
  const SiteLayout({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.useLayout = true,
  });

  //* widget for desktop
  final Widget? desktop;

  //* widgets for tablet
  final Widget? tablet;

  //*widget for mobile
  final Widget? mobile;
  final bool useLayout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: AppResponsiveWidgets(
        desktop:
            useLayout ? DesktopLayout(body: desktop) : desktop ?? Container(),
        tablet:
            useLayout
                ? TabletLayout(body: tablet ?? desktop)
                : tablet ?? Container(),
        mobile:
            useLayout
                ? MobileLayout(body: mobile ?? desktop)
                : tablet ?? Container(),
      ),
    );
  }
}
