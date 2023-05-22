import 'package:ajay_flutter_mobile_task/all_stocks.dart';
import 'package:ajay_flutter_mobile_task/app_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'widgets/app_bar_search_field.dart';
import 'widgets/app_nav_bar.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      home: const WatchListHome(),
    );
  }
}

class WatchListHome extends StatelessWidget {
  const WatchListHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 245, 247, 255).withOpacity(0.9),
      bottomSheet: const BottomNavBar(),
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
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.notifications_active)),
          ),
          const Text(
            "Nifty 50",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            "25,355.80",
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 1),
          RichText(
            text: const TextSpan(
              text: "+13.00(",
              children: [
                TextSpan(text: "+0.12%", style: TextStyle(color: Colors.green)),
                TextSpan(text: ")"),
              ],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(flex: 3, child: _Graph()),
          const Expanded(flex: 4, child: StockBottomSection()),
        ],
      ),
    );
  }
}

class StockBottomSection extends StatelessWidget {
  const StockBottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ["Stocks", "More active stocks"]
                .map(
                  (e) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const AllStocks();
                                  },
                                ));
                              },
                              child: const Text(
                                "See all",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            for (int i = 0; i < 4; i++) const StockCard(),
                          ],
                        ),
                      ),
                      if (e == "Stocks")
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          child: Divider(),
                        ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _Graph extends StatefulWidget {
  const _Graph();

  @override
  State<_Graph> createState() => _GraphState();
}

class _GraphState extends State<_Graph> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    AppProvider appProvider = context.read<AppProvider>();
    appProvider.tabController = TabController(
        length: appProvider.activeTimeFilterTitle.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: SizedBox(
            height: 100,
            child: DefaultTabController(
              length: appProvider.activeTimeFilterTitle.length,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: appProvider.tabController,
                children: [
                  for (int i = 0;
                      i < appProvider.activeTimeFilterTitle.length;
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: LineChartWidget(
                        barWidth: 3,
                        isMiniGraph: false,
                        appProvider.getChartData(Random()),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: appProvider.activeTimeFilterIndex,
          builder: (_, newAppNavValue, __) => Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              // indicator: const BoxDecoration(),
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.blue,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              controller: appProvider.tabController,
              onTap: (index) async {
                appProvider.activeTimeFilterIndex.value = index;
              },
              tabs: appProvider.activeTimeFilterTitle
                  .map(
                    (text) => Tab(
                      height: 23,
                      iconMargin: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            text,
                            style: const TextStyle(fontSize: 16),
                          ),
                          // if (appProvider.activeTab.value ==
                          //     appProvider.activeTimeFilterTitle.indexOf(text))
                          //   Container(
                          //     color: Colors.blue,
                          //     height: 2,
                          //     width: 21,
                          //   )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List points;
  final double barWidth;
  final bool isMiniGraph;

  const LineChartWidget(this.points,
      {Key? key, this.barWidth = 1, this.isMiniGraph = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            barWidth: barWidth,
            belowBarData: BarAreaData(
              show: true,
              // color: Colors.green,
              gradient: isMiniGraph
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: (points[points.length - 1].y < points[0].y)
                          ? [
                              Colors.red.shade400,
                              const Color.fromARGB(255, 245, 247, 255)
                                  .withOpacity(0.9),
                            ]
                          : [
                              Colors.green.shade400,
                              const Color.fromARGB(255, 245, 247, 255)
                                  .withOpacity(0.9),
                            ],
                    )
                  : const LinearGradient(colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ]),
            ),
            spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            isCurved: true,
            dotData: FlDotData(show: false),
            color: (points[points.length - 1].y > points[0].y)
                ? Colors.green
                : Colors.red,
          ),
        ],
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        lineTouchData: LineTouchData(
            enabled: !isMiniGraph,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black,
              // tooltipHorizontalAlignment: FLHorizontalAlignment.center,
              tooltipRoundedRadius: 200.0,
              fitInsideHorizontally: true,
              tooltipPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    const textStyle = TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    );
                    return LineTooltipItem(
                      "\$ ${points[touchedSpot.spotIndex].y.toStringAsFixed(2)}\n 12 Aug, 2023",
                      textStyle,
                    );
                  },
                ).toList();
              },
            ),

            // on commenting the [getTouchedSpotIndicator] the exception -> Exception: indicatorsData and touchedSpotOffsets size should be same will go away - I've raised an issue in github
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return [
                if (!isMiniGraph)
                  TouchedSpotIndicatorData(
                    FlLine(color: Colors.transparent),
                    FlDotData(
                      getDotPainter: (p0, p1, p2, p3) {
                        return FlDotCirclePainter(
                          radius: 6.5,
                          color: Colors.blue.shade500,
                        );
                      },
                    ),
                  ),
              ];
            },
            getTouchLineEnd: (_, __) => double.infinity),
      ),
    );
  }
}

class StockCard extends StatelessWidget {
  const StockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f101828),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x19101828),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
        color: const Color.fromARGB(255, 245, 247, 255).withOpacity(0.9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6)),
              child: const SizedBox(height: 40, width: 40),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "AXISBANK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Axis",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DecoratedBox(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: SizedBox(
                  height: 40,
                  child: LineChartWidget(
                    context.read<AppProvider>().getChartData(Random()),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "2126.33",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                    text: "+13.00 (",
                    children: [
                      TextSpan(
                          text: "+0.12%",
                          style: TextStyle(color: Colors.green)),
                      TextSpan(text: ")"),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
