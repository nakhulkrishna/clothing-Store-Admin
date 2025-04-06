import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/data_table/paginated_data_table.dart';
import 'package:thestyldclubadmin/features/shop/screen.shop/customers/all_constomers/table/cutomer_rows.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,

      columns: [
        DataColumn2(label: Text("Customers")),
        DataColumn2(label: Text("Email")),

        DataColumn2(label: Text("Phone Number")),

        DataColumn2(label: Text("Registered")),

        DataColumn2(label: Text("Action"), fixedWidth: 100),
      ],
      source: CutomerRows(),
    );
  }
}
