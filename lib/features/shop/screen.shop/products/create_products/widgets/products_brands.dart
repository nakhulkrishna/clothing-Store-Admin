import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thestyldclubadmin/common/utils/constants/image_strings.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/models/brandmodel.dart';

class ProductsBrands extends StatelessWidget {
  const ProductsBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        children: [
          Text("Brand", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),

          TypeAheadField(
            builder: (context, controller, focusNode) {
              return TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Brand',
                  suffixIcon: Icon(Iconsax.box),
                ),
              );
            },
            itemBuilder: (context, value) {
              return ListTile(title: Text(""));
            },
            onSelected: (onSelected) {},
            suggestionsCallback: (search) {
              return [
                Brandmodel(id: "id", image: TImages.adidasLogo, name: ""),
                Brandmodel(name: '', id: "id", image: TImages.nikeLogo),
              ];
            },
          ),
        ],
      ),
    );
  }
}
