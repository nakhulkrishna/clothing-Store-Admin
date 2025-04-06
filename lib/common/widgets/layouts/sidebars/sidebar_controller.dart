import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class SidebarController extends GetxController {
  final activeItem = Routes.dashboard.obs;
  final hoveritem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if (activeItem.value != route) hoveritem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHivering(String route) => hoveritem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }
}
