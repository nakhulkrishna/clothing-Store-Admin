import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/controller/category/categorys_controller.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/categorys/screens/allcategorys/table/table_soruce.dart';

class CategorysTable extends StatelessWidget {
  const CategorysTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategorysController());

    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRow.length.toString());
      return TPaginatedDataTable(
        sortAscending: controller.sortAssending.value,
        sortColumnIndex: controller.sortColoumnIndex.value,
        minWidth: 700,
        columns: [
          DataColumn2(
            label: Text("Categorys"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending),
          ),
          DataColumn2(
            label: Text("Parent Categorys"),
            onSort:
                (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending),
          ),

          DataColumn2(label: Text("Featured")),

          DataColumn2(label: Text("Date")),

          DataColumn2(label: Text("Action"), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
