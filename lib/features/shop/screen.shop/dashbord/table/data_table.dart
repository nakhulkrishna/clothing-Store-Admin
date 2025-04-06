import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/dashbord/table/tabale_source.dart';

class DashboardDataTable extends StatelessWidget {
  const DashboardDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: [
        DataColumn2(label: Text("Order ID")),
        DataColumn2(label: Text("Date")),

        DataColumn2(label: Text("Item")),

        DataColumn2(label: Text("Status")),
        DataColumn2(label: Text("Amount")),
      ],
      source: OrderRows(),
    );
  }
}
