import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/appbar/breadcrums/breadcrums_with_heading.dart';
import 'package:thestyldclubadmin/features/shop/models/category_model.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/edit_category/widgets/edit_category_form.dart';
import 'package:thestyldclubadmin/routes/routes.dart';

class EditCategorysMobile extends StatelessWidget {
  const EditCategorysMobile({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Category',
                breadcrumitem: [Routes.categorys, 'Update Category'],
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              EditCategoryForm(categoryModel: categoryModel,),
            ],
          ),
        ),
      ),
    );
  }
}
