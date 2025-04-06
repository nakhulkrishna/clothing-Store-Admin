import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/create_category/widgets/create_categorys_form.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class CreateCategorysTablets extends StatelessWidget {
  const CreateCategorysTablets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                heading: 'Create Category',
                breadcrumitem: [Routes.categorys, 'Create Category'],
                returnToPreviousScreen: true,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              CreateCategorysForm(),
            ],
          ),
        ),
      ),
    );
  }
}
