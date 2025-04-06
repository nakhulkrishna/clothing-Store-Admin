import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/texts/section_heading.dart';

class TDhasboardCard extends StatelessWidget {
  const TDhasboardCard({
    super.key,

    required this.title,
    required this.subtitle,
    this.icon = Iconsax.arrow_up_3,
    required this.status,
    this.onTap,
    this.color = TColors.success,
  });

  final String title, subtitle;
  final IconData icon;
  final int status;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          TSectionHeading(title: title, textColor: TColors.textSecondary),
          SizedBox(height: TSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: Theme.of(context).textTheme.headlineMedium),
              Column(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: TSizes.sm),

                        Text(
                          "$status%",
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: color,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      "Comapred to Dec 2025",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
