// ignore_for_file: camel_case_types, must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';
import 'package:simple_trading_strategy_tester/pages/widgets/trade.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      color: Colors.grey.shade800,
      child: ListView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "Strategy Performance",
              style: TextStyle(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const PerformancePage_FinalCap(),
          const SizedBox(height: 10),
          const PerformancePage_OHLC(),
          const SizedBox(height: 10),
          const PerformancePage_CapitalCurve(),
          const SizedBox(height: 10),
          const PerformancePage_ProfitLoss(),
          const SizedBox(height: 10),
          const PerformancePage_Winrate(),
          const SizedBox(height: 10),
          const PerformanceTrade_Factor(),
          const SizedBox(height: 10),
          const PerformancePage_Max()
        ],
      ),
    );
    // FutureBuilder(
    //     future: controller.getPerformance_perf(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return ListView(
    //           padding: const EdgeInsets.only(
    //             left: 10,
    //             top: 32,
    //             right: 10,
    //             bottom: 10,
    //           ),
    //           children: <Widget>[
    //             Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 "Strategy Performance",
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline1!
    //                     .merge(const TextStyle(fontSize: 14)),
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             const PerformancePage_FinalCap(),
    //             const SizedBox(height: 10),
    //             const PerformancePage_OHLC(),
    //             const SizedBox(height: 10),
    //             const PerformancePage_CapitalCurve(),
    //             const SizedBox(height: 10),
    //             const PerformancePage_ProfitLoss(),
    //             const SizedBox(height: 10),
    //             const PerformancePage_Winrate(),
    //             const SizedBox(height: 10),
    //             const PerformanceTrade_Factor(),
    //             const SizedBox(height: 10),
    //             const PerformancePage_Max()
    //           ],
    //         );
    //       } else {
    //         return const CircularProgressIndicator.adaptive();
    //       }
    //     });
  }
}

class PerformancePage_FinalCap extends StatelessWidget {
  const PerformancePage_FinalCap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.finalCap.value)
                      .output
                      .compactNonSymbol,
                  style:
                      controller.finalCap.value >= controller.initCap_info.value
                          ? const TextStyle(
                              color: Colors.greenAccent,
                            )
                          : const TextStyle(
                              color: Colors.redAccent,
                            ),
                ),
              ),
              Text(
                "Final Capital",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Obx(
                    () => controller.gain.value >= 0
                        ? const Icon(
                            Icons.trending_up_rounded,
                            color: Color(0xFF80FFDB),
                          )
                        : const Icon(
                            Icons.trending_down_rounded,
                            color: Color(0xFFF72585),
                          ),
                  ),
                  const SizedBox(width: 5),
                  Obx(
                    () => Text(
                      "${(controller.tradeList.isNotEmpty ? MoneyFormatter(amount: controller.gain.value).output.compactNonSymbol : 0)}%",
                      style: controller.gain.value >= 0
                          ? const TextStyle(
                              color: Colors.greenAccent,
                            )
                          : const TextStyle(
                              color: Colors.redAccent,
                            ),
                    ),
                  ),
                ],
              ),
              Text(
                "Gain Percentage",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.totalVolume.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Total Volume",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerformancePage_OHLC extends StatelessWidget {
  const PerformancePage_OHLC({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Obx(
            () => Text(
              controller.tradingPair_info.value.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "o ",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.initCap_info.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "h ",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.high.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "l ",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(
                          amount: controller.low.value >
                                  controller.initCap_info.value
                              ? controller.initCap_info.value
                              : controller.low.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "c ",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.finalCap.value)
                      .output
                      .compactNonSymbol,
                  style:
                      controller.finalCap.value > controller.initCap_info.value
                          ? const TextStyle(
                              color: Colors.greenAccent,
                            )
                          : const TextStyle(
                              color: Colors.redAccent,
                            ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformancePage_CapitalCurve extends StatelessWidget {
  const PerformancePage_CapitalCurve({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Capital Curve",
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => controller.tradeList.isNotEmpty
                  ? Obx(
                      () => LineChart(
                        swapAnimationDuration:
                            const Duration(milliseconds: 500),
                        LineChartData(
                          minX: 0,
                          maxX: controller.tradeList.length.toDouble(),
                          minY: controller.low.value,
                          maxY: controller.high.value,
                          gridData: FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          titlesData: FlTitlesData(
                            show: false,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              dotData: FlDotData(show: false),
                              color: controller.tradeList.last.cap >
                                      controller.initCap_info.value
                                  ? const Color(0xFF80FFDB)
                                  : const Color(0xFFF72585),
                              isStrokeCapRound: true,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: controller.initCap_info.value <
                                        controller.tradeList.last.cap
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0x8080FFDB),
                                          Color(0x1A80FFDB)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0x80F72585),
                                          Color(0x1AF72585)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                              ),
                              spots: List.generate(
                                controller.tradeList.length,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  controller.tradeList[index].cap,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Text(
                      "No trade yet",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class PerformancePage_ProfitLoss extends StatelessWidget {
  const PerformancePage_ProfitLoss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Profit Calculation",
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gross profit",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.grossProfit.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gross loss",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.grossLoss.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                  "Total fee (avg ${MoneyFormatter(amount: controller.averageFee.value).output.compactNonSymbol})",
                  style: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.totalFee.value)
                      .output
                      .compactNonSymbol,
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.blueGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Neto profit",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Obx(
                () => Text(
                  MoneyFormatter(amount: controller.netoProfit.value)
                      .output
                      .compactNonSymbol,
                  style: controller.netoProfit.value > 0
                      ? const TextStyle(
                          color: Colors.greenAccent,
                        )
                      : const TextStyle(
                          color: Colors.redAccent,
                        ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformancePage_Winrate extends StatelessWidget {
  const PerformancePage_Winrate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Win Trade",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Text(
                "Profit Factor",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              Text(
                "Lose Trade",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                  "${controller.winrate.value.toStringAsPrecision(4)}%",
                  style: const TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  controller.profitFactor.value.toStringAsPrecision(2),
                  style: controller.profitFactor.value > 0
                      ? const TextStyle(
                          color: Colors.greenAccent,
                        )
                      : const TextStyle(
                          color: Colors.redAccent,
                        ),
                ),
              ),
              Obx(
                () => Text(
                  "${(100 - controller.winrate.value).toStringAsPrecision(4)}%",
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          IgnorePointer(
            child: SliderTheme(
              data: SliderThemeData(
                disabledActiveTrackColor: Colors.blue,
                disabledInactiveTrackColor: Colors.black12,
                trackHeight: 3,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 0.0,
                ),
                trackShape: const RoundedRectSliderTrackShape(),
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Obx(
                () => Slider(
                  max: 100,
                  min: 1,
                  value: controller.winrate.value,
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.redAccent,
                  onChanged: (newValue) {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                  controller.winTrade.value.toString(),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Total Trade ",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.totalTrade.value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Text(
                  controller.loseTrade.value.toString(),
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PerformanceTrade_Factor extends StatelessWidget {
  const PerformanceTrade_Factor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Trading Factor",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 5),
          Table(
            border: TableBorder.all(
              color: const Color(0xFF495057),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            children: <TableRow>[
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Trade Type",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Win",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lose",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Cosecutive",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${controller.consecutiveWin.value}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${controller.consecutiveLoss.value}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Largest Nominal",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        MoneyFormatter(
                                amount: controller.largestWinNominal.value)
                            .output
                            .compactNonSymbol,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        MoneyFormatter(
                                amount: -controller.largestLossNominal.value)
                            .output
                            .compactNonSymbol,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Largest Percentage",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${MoneyFormatter(amount: controller.largestWinPercentage.value).output.compactNonSymbol}%",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${MoneyFormatter(amount: -controller.largestLossPercentage.value).output.compactNonSymbol}%",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Average Nominal",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        MoneyFormatter(
                                amount: controller.averageWinNominal.value)
                            .output
                            .compactNonSymbol,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        MoneyFormatter(
                                amount: -controller.averageLossNominal.value)
                            .output
                            .compactNonSymbol,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Average Percentage",
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${MoneyFormatter(amount: controller.averageWinPercentage.value).output.compactNonSymbol}%",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${MoneyFormatter(amount: -controller.averageLossPercentage.value).output.compactNonSymbol}%",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerformancePage_Max extends StatelessWidget {
  const PerformancePage_Max({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Max Posibility",
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.trending_down_rounded,
                        color: Color(0xFFF72585),
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => Text(
                          "${controller.maxDrawdownPercentage.value.toStringAsPrecision(4)}%",
                          style: const TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Max Drawdown",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Obx(
                        () => Text(
                          "${controller.maxRunUpPercentage.value.toStringAsPrecision(4)}%",
                          style: const TextStyle(
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.trending_up_rounded,
                        color: Color(0xff80ffdb),
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Max RunUp",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
