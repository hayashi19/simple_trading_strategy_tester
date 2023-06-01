// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';

import 'package:simple_trading_strategy_tester/controller/controller.dart';
import 'package:simple_trading_strategy_tester/pages/drawer.dart';
import 'package:simple_trading_strategy_tester/pages/indicator.dart';
import 'package:simple_trading_strategy_tester/pages/performance.dart';
import 'package:simple_trading_strategy_tester/pages/trade.dart';
import 'package:simple_trading_strategy_tester/widgets/c_ads.dart';
import 'package:simple_trading_strategy_tester/widgets/c_textfield.dart';

class HomePage_Mobile extends StatelessWidget {
  const HomePage_Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    printInfo(info: "COBA COBA COBA COBA COBA COBA COBA COBA ");
    return KeyboardVisibility(
      onChanged: (newVisibility) =>
          controller.tradeController.tabNavVisibility.value = !newVisibility,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: AppbarTextfield(
            hint: "strategy title",
            inputType: TextInputType.name,
            minLine: 1,
            maxLine: 1,
            textFocus: controller.tradingInfoInput.strategyTitleFocus.value,
            textFocusOnChange: (newFocus) {
              controller.tradingInfoInput.changeFocus(
                controller.tradingInfoInput.strategyTitleFocus,
                newFocus,
                context,
              );
            },
            textController: controller.tradingInfoInput.strategyTitleController,
            onChangeValue: (newValue) {
              controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.strategyTitle,
                newValue,
              );
            },
          ),
          actions: [
            Ink(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  if (controller.adsController.adIsLoaded.value) {
                    controller.adsController.interstitialAd.show();
                  }
                  controller.tradeController.setStrategy();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: const Icon(Icons.save_rounded),
                ),
              ),
            )
          ],
        ),
        drawer: const DrawerPage(),
        body: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Column(
            children: <Widget>[
              const Expanded(
                child: TabBarView(
                  children: [
                    PerformancePage(),
                    TradePage(),
                    IndicatorPage(),
                  ],
                ),
              ),
              BannerAds(ad: controller.adsController.listBanner),
              Obx(
                () => Visibility(
                  visible: controller.tradeController.tabNavVisibility.value,
                  child: const TabBar(
                    tabs: <Padding>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.show_chart_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.candlestick_chart_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.bar_chart_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     if (controller.adsController.adIsLoaded.value) {
        //       controller.adsController.interstitialAd.show();
        //     }
        //     controller.tradeController.setStrategy();
        //   },
        //   child: const Icon(Icons.save_rounded),
        // ),
      ),
    );
  }
}
