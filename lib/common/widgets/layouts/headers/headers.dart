import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_rounded_image.dart';
import 'package:thestyldclubadmin/common/widgets/shimmers/shimmer.dart';
import 'package:thestyldclubadmin/features/authentication/controllers/user_controller.dart';


class Headers extends StatelessWidget implements PreferredSizeWidget {
  const Headers({super.key, this.scaffoldKey});

  //* GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        //* Search Field
        title:
            TDeviceUtils.isDesktopScreen(context)
                ? SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefix: Icon(Iconsax.search_normal),
                      hintText: "Search anything...",
                    ),
                  ),
                )
                : null,

        //* Mobile Menu
        leading:
            !TDeviceUtils.isDesktopScreen(context)
                ? IconButton(
                  onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                  icon: Icon(Iconsax.menu),
                )
                : null,
        actions: [
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),
          IconButton(onPressed: () {}, icon: Icon(Iconsax.notification)),
          const SizedBox(width: TSizes.spaceBtwItems / 2),

          //* User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => TRoundedImage(
                  width: 40,
                  padding: 2,
                  height: 40,
                  imageType:
                      controller.user.value.profilePicture.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                  image:
                      controller.user.value.profilePicture.isNotEmpty
                          ? controller.user.value.profilePicture
                          : TImages.user,
                ),
              ),
              SizedBox(width: TSizes.sm),
              if (!TDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                            controller.user.value.fullname,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                      controller.loading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                            controller.user.value.email,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
