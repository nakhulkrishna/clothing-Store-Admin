import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/responsive_screen/settings_desk_top.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/responsive_screen/settings_mobile.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/settings/responsive_screen/settings_tablet.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: SettingsDeskTop(),
      tablet: SettingsTablet(),
      mobile: SettingsMobile(),
    );
  }
}
