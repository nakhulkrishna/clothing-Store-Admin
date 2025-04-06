import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';

class AppSettingsFrom extends StatelessWidget {
  const AppSettingsFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App Settings",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: TSizes.spaceBtwSections),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: "App Name",
                    label: Text("App Name"),
                    prefix: Icon(Iconsax.user),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Tax %",
                          label: Text("Tax Rate (%)"),
                          prefix: Icon(Iconsax.tag),
                        ),
                      ),
                    ),
                    SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Shipping Cost",
                          label: Text("Shipping Cost (\$)"),
                          prefix: Icon(Iconsax.ship),
                        ),
                      ),
                    ),
                    SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Free Shipping After",
                          label: Text("Shipping Thershold (\$)"),
                          prefix: Icon(Iconsax.ship),
                        ),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Update App"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
