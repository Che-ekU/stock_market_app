import 'package:ajay_flutter_mobile_task/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ValueListenableBuilder<int>(
        valueListenable: appProvider.activeTab,
        builder: (_, newAppNavValue, __) => Row(
          children: appProvider.tabTitle
              .map((e) => Expanded(
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        appProvider.activeTab.value =
                            appProvider.tabTitle.indexOf(e);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Icon(
                            appProvider
                                .tabIcons[appProvider.tabTitle.indexOf(e)],
                            color: appProvider.activeTab.value ==
                                    appProvider.tabTitle.indexOf(e)
                                ? Colors.blue
                                : Colors.grey,
                            size: 28,
                          ),
                          const SizedBox(height: 5),
                          if (appProvider.tabTitle.indexOf(e) ==
                              appProvider.activeTab.value)
                            Column(
                              children: [
                                Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 20,
                                  height: 2,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
