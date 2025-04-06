import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/controller/banner/banner_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/banner/all_banner/widgets/banner_rows.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRow.length.toString());
      return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 900,
        dataRowHeight: 110,
        columns: [
          DataColumn2(label: Text("Banner")),
          DataColumn2(label: Text('Redirect Screen')),
          DataColumn2(label: Text('Active')),
          DataColumn2(label: Text('Atcion'), fixedWidth: 100),
        ],
        source: BannerRows(),
      );
    });
  }
}
