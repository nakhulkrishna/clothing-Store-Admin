import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/validators/validation.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';

class PrifileFrom extends StatelessWidget {
  const PrifileFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile Details",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  "First Name",
                                  value,
                                ),
                            decoration: InputDecoration(
                              hintText: "First Name",
                              label: Text("Fist Name"),
                              prefix: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  "Last Name",
                                  value,
                                ),
                            decoration: InputDecoration(
                              hintText: "Last Name",
                              label: Text("Last Name"),
                              prefix: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  "Email",
                                  value,
                                ),
                            decoration: InputDecoration(
                              hintText: "Email",
                              label: Text("Email"),
                              prefix: Icon(Iconsax.forward),
                            ),
                          ),
                        ),
                        SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: TextFormField(
                            validator:
                                (value) => TValidator.validateEmptyText(
                                  "Phone Number",
                                  value,
                                ),
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              label: Text("Phone Number"),
                              prefix: Icon(Iconsax.mobile),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Update Profile"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
