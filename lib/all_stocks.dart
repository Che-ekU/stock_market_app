import 'package:flutter/material.dart';
import 'watchlist.dart';
import 'widgets/app_bar_search_field.dart';
import 'widgets/app_nav_bar.dart';

class AllStocks extends StatelessWidget {
  const AllStocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 245, 247, 255).withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
        title: const AppBarSearchField(),
      ),bottomSheet: BottomNavBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        margin: const EdgeInsets.only(top: 40.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "All stocks",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 15; i++) const StockCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
