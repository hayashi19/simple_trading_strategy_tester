import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simple_trading_strategy_tester/controller/controller.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      padding: EdgeInsets.all(0),
      children: <Widget>[
        StrategyTitle(),
        SizedBox(height: 10),
        Row(
          children: const <Widget>[
            Expanded(child: TradingPair()),
            SizedBox(width: 10),
            Expanded(child: Timeframe()),
            SizedBox(width: 10),
            Expanded(child: StrategyDuration()),
          ],
        ),
        const SizedBox(height: 10),
        InitialCap(),
        const SizedBox(height: 10),
        Row(
          children: const <Widget>[
            Expanded(child: Budget()),
            SizedBox(width: 10),
            Expanded(child: Leverage()),
            SizedBox(width: 10),
            Expanded(child: Fee()),
          ],
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Text(
            "all data above is in constant value",
            style: TextStyle(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 10),
        const TradePercentage(),
        const SizedBox(height: 10),
        Row(
          children: const <Widget>[
            Expanded(child: AddTradeButton()),
            SizedBox(width: 10),
            Expanded(child: DeleteTradeButton()),
          ],
        ),
      ],
    );
  }
}

class StrategyTitle extends StatelessWidget {
  const StrategyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.edit_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.strategyTitleController_info,
              decoration: const InputDecoration.collapsed(
                hintText: "your strategy name . . .",
              ),
              onChanged: (value) => controller.getStrategyTitle(),
            ),
          ),
        ],
      ),
    );
  }
}

class TradingPair extends StatelessWidget {
  const TradingPair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.currency_bitcoin_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.tradingPairController_info,
              decoration: const InputDecoration.collapsed(
                hintText: "pair xx/xx",
              ),
              onChanged: (value) => controller.getTradingPair(),
            ),
          ),
        ],
      ),
    );
  }
}

class Timeframe extends StatelessWidget {
  const Timeframe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.timer_10_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.timeFrameController_info,
              decoration: const InputDecoration.collapsed(
                hintText: "timeframe",
              ),
              onChanged: (value) => controller.getTimeframe(),
            ),
          ),
        ],
      ),
    );
  }
}

class StrategyDuration extends StatelessWidget {
  const StrategyDuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.date_range,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.durationController_info,
              decoration: const InputDecoration.collapsed(
                hintText: "duration",
              ),
              onChanged: (value) => controller.getDuration(),
            ),
          ),
        ],
      ),
    );
  }
}

class InitialCap extends StatelessWidget {
  const InitialCap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.wallet_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.initCapController_info,
              decoration: const InputDecoration.collapsed(
                hintText: "type init capital",
              ),
              onChanged: (value) async {
                try {
                  !(value.isNum)
                      ? controller.initCapController_info.clear()
                      : null;
                } catch (e) {
                  debugPrint(e.toString());
                }
                controller.getInitCap();
                controller.editTrade("");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.percent_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.budgetController_trade,
              decoration: const InputDecoration.collapsed(
                hintText: "bugdet per trade",
              ),
              onChanged: (value) async {
                try {
                  !(value.isNum)
                      ? controller.budgetController_trade.clear()
                      : null;
                } catch (e) {
                  debugPrint(e.toString());
                }
                controller.getBudget();
                controller.editTrade("budget");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Leverage extends StatelessWidget {
  const Leverage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.one_x_mobiledata_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.leverageController_trade,
              decoration: const InputDecoration.collapsed(
                hintText: "leverage x",
              ),
              onChanged: (value) async {
                try {
                  !(value.isNum)
                      ? controller.leverageController_trade.clear()
                      : null;
                } catch (e) {
                  debugPrint(e.toString());
                }
                controller.getLeverage();
                controller.editTrade("leverage");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Fee extends StatelessWidget {
  const Fee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.money_off_csred_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.feeController_trade,
              decoration: const InputDecoration.collapsed(
                hintText: "fee (%)",
              ),
              onChanged: (value) async {
                try {
                  !(value.isNum)
                      ? controller.feeController_trade.clear()
                      : null;
                } catch (e) {
                  debugPrint(e.toString());
                }
                controller.getFee();
                controller.editTrade("fee");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TradePercentage extends StatelessWidget {
  const TradePercentage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.ssid_chart_rounded,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.tradePercentageController_trade,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                controller.addTrade();
                controller.getPerformance_perf();
              },
              decoration: const InputDecoration.collapsed(
                hintText: "profit loss percentage",
              ),
              onChanged: (value) async {
                controller.getTradePercentage();
                // controller.editTrade("trade");
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddTradeButton extends StatelessWidget {
  const AddTradeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.all(20),
        ),
      ),
      onPressed: () => controller.addTrade(),
      icon: Icon(Icons.add_rounded),
      label: Obx(
        () => Text(
          "Add #${controller.tradeList.length} Trade",
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class DeleteTradeButton extends StatelessWidget {
  const DeleteTradeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.all(20),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.red.shade800,
        ),
      ),
      onPressed: () => controller.removeTrade(),
      icon: Icon(Icons.delete_forever_rounded),
      label: Text(
        "Delete Prev Trade",
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
