// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_trading_strategy_tester/controller/ads.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';

import 'package:simple_trading_strategy_tester/pages/drawer.dart';
import 'package:simple_trading_strategy_tester/pages/widgets/trade.dart';
import 'package:simple_trading_strategy_tester/pages/widgets/history.dart';
import 'package:simple_trading_strategy_tester/pages/widgets/indicator.dart';
import 'package:simple_trading_strategy_tester/pages/widgets/performance.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Strategy"),
      ),
      drawer: const DrawerPage(),
      body: GetPlatform.isMobile
          ? const HomePage_Mobile()
          : const HomePage_Desktop(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.interstitialAd.show();
          controller.setStrategy();
        },
        child: const Icon(Icons.save_rounded),
      ),
    );
  }
}

class HomePage_Mobile extends StatelessWidget {
  const HomePage_Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TabBarView(
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      Expanded(child: TradePage()),
                      Divider(
                        height: 24,
                        color: Colors.grey,
                      ),
                      Expanded(child: HistoryPage()),
                    ],
                  ),
                  const PerformancePage(),
                  const IndicatorPage(),
                ],
              ),
            ),
          ),
          ADS(ad: controller.listBanner),
          const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.candlestick_chart_rounded),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.show_chart_rounded),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.bar_chart_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePage_Desktop extends StatelessWidget {
  const HomePage_Desktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            flex: 1,
            child: PerformancePage(),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(child: HistoryPage()),
                      SizedBox(width: 10),
                      Expanded(child: TradePage())
                    ],
                  ),
                ),
                const Divider(
                  height: 24,
                  thickness: 2,
                  color: Colors.grey,
                ),
                const Expanded(
                  flex: 2,
                  child: IndicatorPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
