import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/colors.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/device/device_utility.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/features/shop/controller/dashboard/dashboard_controller.dart';


class WeeklySales extends StatelessWidget {
  const WeeklySales({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Sales",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: TSizes.spaceBtwSections),

          SizedBox(
            height: 500,
            child: BarChart(
              BarChartData(
                barGroups:
                    controller.weekSales
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                width: 30,
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(TSizes.sm),
                                toY: entry.value,
                              ),
                            ],
                          ),
                        )
                        .toList(),

                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => TColors.secondary,
                  ),
                  touchCallback:
                      TDeviceUtils.isDesktopScreen(context)
                          ? (barTouchEvent, barTouchREsponse) {}
                          : null,
                ),
                groupsSpace: TSizes.spaceBtwItems,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 200,
                ),
                titlesData: buildFlTitleData(),
                borderData: FlBorderData(
                  show: true,
                  border: Border(top: BorderSide.none, right: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitleData() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          final index = value.toInt() % days.length;

          final day = days[index];

          return SideTitleWidget(
            space: 0,
            axisSide: AxisSide.bottom,
            child: Text(day),
          );
        },
      ),
    ),

    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
