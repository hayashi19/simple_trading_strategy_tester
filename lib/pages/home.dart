import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        onPressed: () => controller.setStrategy(),
        child: const Icon(Icons.save_rounded),
      ),
    );
  }
}

class HomePage_Mobile extends StatelessWidget {
  const HomePage_Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePage_Desktop extends StatelessWidget {
  const HomePage_Desktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
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
                // Obx(() => Text(controller.tradeList.value.toString())),
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
                Divider(
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
