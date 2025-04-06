import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/templates/site_layout.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/profile/responsive_screen/profile_desk_top.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/profile/responsive_screen/profile_mobile.dart';
import 'package:thestyldclubadmin/features/persnalizations/screens/profile/responsive_screen/profile_tablet.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: ProfileDeskTop(),
      tablet: ProfileTablet(),
      mobile: ProfileMobile(),
    );
  }
}
