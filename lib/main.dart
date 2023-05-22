import 'package:ajay_flutter_mobile_task/app_provider.dart';
import 'package:ajay_flutter_mobile_task/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
        child: const WatchList()),
  );
}
