import 'package:flutter/material.dart';
import 'package:thestyldclubadmin/common/widgets/containers/rounded_container.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/headers/headers.dart';
import 'package:thestyldclubadmin/common/widgets/layouts/sidebars/sidebars.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});
  final Widget? body;

  //* GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebars(),
      appBar: Headers(scaffoldKey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
