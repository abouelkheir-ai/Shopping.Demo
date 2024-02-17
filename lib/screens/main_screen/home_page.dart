import 'package:fake_api/screens/widgets/main_page/categories.dart';
import 'package:fake_api/screens/widgets/main_page/slider_builder.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.grey.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            const MySlider(),
            const SizedBox(height: 20),
            const CategoriesGrid(),
          ],
        ),
      ),
    );
  }
}
