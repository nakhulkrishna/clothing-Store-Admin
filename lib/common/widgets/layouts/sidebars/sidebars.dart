import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/images/t_circular_image.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/sidebars/menu/menu_items.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class Sidebars extends StatelessWidget {
  const Sidebars({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // image
              TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MENU",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                    ),

                    TMenuItem(
                      icon: Iconsax.status,
                      itemName: "Dashboard",
                      route: Routes.dashboard,
                    ),
                    TMenuItem(
                      icon: Iconsax.image,
                      itemName: "Media",
                      route: Routes.media,
                    ),
                    TMenuItem(
                      icon: Iconsax.category_2,
                      itemName: "Categorys",
                      route: Routes.categorys,
                    ),
                    TMenuItem(
                      icon: Iconsax.dcube,
                      itemName: "Brands",
                      route: Routes.brands,
                    ),
                    TMenuItem(
                      icon: Iconsax.picture_frame,
                      itemName: "Banner",
                      route: Routes.banners,
                    ),
                    TMenuItem(
                      icon: Iconsax.shopping_bag,
                      itemName: "Products",
                      route: Routes.products,
                    ),
                    TMenuItem(
                      icon: Iconsax.user,
                      itemName: "Customer",
                      route: Routes.customers,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
