
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class RouteObserver extends GetObserver {
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if (previousRoute != null) {
      for (var routeName in Routes.sidebarMenuItem) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
  // void didPush(Route<dynamic>? route, Route<dynamic>? previousRoutes) {
  //   final sidebarController = Get.put(sidebarController());

  //   if (route != null) {
  //     for (var routeName in Routes.sideMenuItems) {
  //       if (route.settings.name == routeName) {
  //         sidebarController.activeItem.valu = routeName;
  //       }
  //     }
  //   }
  // }
}
