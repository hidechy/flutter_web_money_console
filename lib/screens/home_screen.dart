import 'package:flutter/material.dart';

import 'menu_screen.dart';
import 'money_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: MenuScreen(),
            ),
            Expanded(child: MoneyListScreen()),
          ],
        ),
      ),
    );
  }
}
