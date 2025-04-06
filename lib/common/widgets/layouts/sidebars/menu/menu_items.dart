import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/sidebars/sidebar_controller.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });
  final String route;
  final IconData icon;
  final String itemName;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),

      onHover:
          (hovering) =>
              hovering
                  ? menuController.changeHoverItem(route)
                  : menuController.changeHoverItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color:
                  menuController.isHivering(route) ||
                          menuController.isActive(route)
                      ? TColors.primary
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: TSizes.lg,
                    right: TSizes.md,
                    top: TSizes.md,
                    bottom: TSizes.md,
                  ),
                  child:
                      menuController.isActive(route)
                          ? Icon(icon, color: TColors.white, size: 22)
                          : Icon(
                            size: 22,
                            icon,
                            color:
                                menuController.isHivering(route)
                                    ? TColors.white
                                    : TColors.darkerGrey,
                          ),
                ),
                if (menuController.isHivering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: TColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: TColors.darkGrey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
