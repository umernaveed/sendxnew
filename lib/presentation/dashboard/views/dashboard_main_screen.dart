import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/dashboard/views/dashboard.dart';

class DashboardMainScreen extends StatelessWidget {
  const DashboardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      value: SystemUiOverlayStyle.dark,
      showGradients: false,
      backgroundColor: Color(0xFFF8FBFF),
      body: Dashboard(),
    );
  }
}
