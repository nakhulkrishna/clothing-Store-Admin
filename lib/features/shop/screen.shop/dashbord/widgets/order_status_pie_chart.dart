import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/helpers/helper_functions.dart';
import 'package:thestyldclubadmin/common/widgets/containers/circular_container.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/controller/dashboard/dashboard_controller.dart';


class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final contoller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: TSizes.spaceBtwSections),

          //Graph
          SizedBox(
            height: 400,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
                sections:
                    contoller.orderStatusData.entries.map((entry) {
                      final statuss = entry.key;
                      final count = entry.value;
                      return PieChartSectionData(
                        color: THelperFunctions.getOrderStatusColor(statuss),
                        title: count.toString(),
                        value: count.toDouble(),
                        radius: 100,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Orders")),
                DataColumn(label: Text("Total")),
              ],
              rows:
                  contoller.orderStatusData.entries.map((entry) {
                    final OrderStatus status = entry.key;
                    final int count = entry.value;
                    final totalAmount = contoller.totalAmount[status] ?? 0;
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              TCircularContainer(
                                width: 20,
                                height: 20,
                                backgroundColor:
                                    THelperFunctions.getOrderStatusColor(
                                      status,
                                    ),
                              ),
                              SizedBox(width: TSizes.defaultSpace),
                              Expanded(
                                child: Text(
                                  contoller.getDisplayStatusName(status),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(count.toString())),
                        DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
