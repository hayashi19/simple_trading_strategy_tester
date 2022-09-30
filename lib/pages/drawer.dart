// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 16,
                  right: 10,
                  bottom: 16,
                ),
                child: Column(
                  children: const <Widget>[
                    Text(
                      "List of Strategy",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: StrategyList()),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 32,
                  right: 10,
                  bottom: 16,
                ),
                child: Column(
                  children: const <Widget>[
                    Text(
                      "List of Strategy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: StrategyList()),
                  ],
                ),
              ),
            ),
          );
  }
}

class StrategyList extends StatelessWidget {
  const StrategyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Obx(
      () {
        return controller.strategyList.isEmpty
            ? const Center(
                child: Text(
                  "No strategy yet",
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: controller.strategyList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      StrategyList_Detail(index: index),
                ),
              );
      },
    );
  }
}

class StrategyList_Detail extends StatelessWidget {
  int index;
  StrategyList_Detail({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return InkWell(
      onTap: () => controller.getStrategy(index),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StrategyList_Detail_Leading(index: index),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StrategyList_Detail_Ttitle(index: index),
                  StrategyList_Detail_Duration(index: index),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: StrategyList_Detail_Winrate(index: index),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 2,
              child: StrategyList_Detail_Gain(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

class StrategyList_Detail_Leading extends StatelessWidget {
  int index;
  StrategyList_Detail_Leading({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return IconButton(
      onPressed: () {
        controller.removeStrategy(index);
        // Get.back();
      },
      iconSize: 24,
      icon: const Icon(Icons.delete_rounded),
    );
  }
}

class StrategyList_Detail_Ttitle extends StatelessWidget {
  int index;
  StrategyList_Detail_Ttitle({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Obx(
      () => Text(
        controller.strategyList[index].strategyTitle.isEmpty
            ? "Title ${index + 1}"
            : controller.strategyList[index].strategyTitle.toString(),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }
}

class StrategyList_Detail_Duration extends StatelessWidget {
  int index;
  StrategyList_Detail_Duration({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Obx(
      () => Text(
        controller.strategyList[index].duration.toString(),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}

class StrategyList_Detail_Winrate extends StatelessWidget {
  int index;
  StrategyList_Detail_Winrate({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Obx(
            () => Text(
              controller.strategyList[index].winrate.toString(),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: controller.strategyList[index].winrate >= 0
                  ? const TextStyle(
                      color: Colors.greenAccent,
                    )
                  : const TextStyle(
                      color: Colors.redAccent,
                    ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "%",
          softWrap: false,
          style: controller.strategyList[index].winrate >= 0
              ? const TextStyle(
                  color: Colors.greenAccent,
                )
              : const TextStyle(
                  color: Colors.redAccent,
                ),
        ),
      ],
    );
  }
}

class StrategyList_Detail_Gain extends StatelessWidget {
  int index;
  StrategyList_Detail_Gain({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(
            () => controller.strategyList[index].gain >= 0
                ? const Icon(
                    Icons.arrow_drop_up_rounded,
                    size: 20,
                    color: Colors.greenAccent,
                  )
                : const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 20,
                    color: Colors.redAccent,
                  ),
          ),
          Expanded(
            child: Obx(
              () => Text(
                MoneyFormatter(amount: controller.strategyList[index].gain)
                    .output
                    .compactNonSymbol,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: controller.strategyList[index].gain >= 0
                    ? const TextStyle(
                        color: Colors.greenAccent,
                      )
                    : const TextStyle(
                        color: Colors.redAccent,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "%",
            softWrap: false,
            style: controller.strategyList[index].gain >= 0
                ? const TextStyle(
                    color: Colors.greenAccent,
                  )
                : const TextStyle(
                    color: Colors.redAccent,
                  ),
          ),
        ],
      ),
    );
  }
}
