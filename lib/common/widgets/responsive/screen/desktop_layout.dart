import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/headers/headers.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/sidebars/sidebars.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Sidebars()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                //HEADER
                Headers(),

                //BODY
                Expanded(child: body ?? const SizedBox()),
                // TRoundedContainer(
                //   width: double.infinity,
                //   height: 500,
                //   backgroundColor: Colors.blue.withOpacity(0.2),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
