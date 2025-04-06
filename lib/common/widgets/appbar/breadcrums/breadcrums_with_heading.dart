// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/texts/page_heading.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class BreadcrumsWithHeading extends StatelessWidget {
  const BreadcrumsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumitem,
    this.returnToPreviousScreen = false,
  });
  // the heading for the page
  final String heading;
  // List of breadcrums item representiong the navigation path
  final List<String> breadcrumitem;
  // falg indicating whether to include a button to return to previous screen
  final bool returnToPreviousScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(Routes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xs),
                child: Text(
                  "Dashboard",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumitem.length; i++)
              Row(
                children: [
                  Text("/"), //sepretor
                  InkWell(
                    onTap:
                        i == breadcrumitem.length - 1
                            ? null
                            : () => Get.toNamed(breadcrumitem[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      child: Text(
                        i == breadcrumitem.length - 1
                            ? breadcrumitem[i].capitalize.toString()
                            : capitalizes(breadcrumitem[i].substring(1)),
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(height: TSizes.sm),

        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Iconsax.arrow_left),
              ),

            if (returnToPreviousScreen)
              const SizedBox(width: TSizes.spaceBtwItems),
            TPageHeading(heading: heading),
          ],
        ),
      ],
    );
  }
}

String capitalizes(String s) {
  return s.isEmpty ? "" : s[0].toUpperCase() + s.substring(1);
}
