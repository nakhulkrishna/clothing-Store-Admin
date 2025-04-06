import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/text_strings.dart';
import 'package:thestyldclubadmin/common/utils/device/web_material_scroll.dart';
import 'package:thestyldclubadmin/common/utils/genarall_bindings/genaral_bindings.dart';
import 'package:thestyldclubadmin/common/utils/theme/theme.dart';

import 'package:thestyldclubadmin/routes/app_routes.dart';
import 'package:thestyldclubadmin/routes/routes.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GenaralBindings(),
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      getPages: AppRoutes.pages,
      initialRoute: Routes.dashboard,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => Scaffold(body: Center(child: Text("page not found"))),
      ),
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}

