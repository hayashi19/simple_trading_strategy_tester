// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simple_trading_strategy_tester/controller/controller.dart';
import 'package:simple_trading_strategy_tester/widgets/c_button.dart';
import 'package:simple_trading_strategy_tester/widgets/c_listview.dart';
import 'package:simple_trading_strategy_tester/widgets/c_textfield.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + 10,
        top: MediaQuery.of(context).padding.top + 10,
        right: MediaQuery.of(context).padding.right + 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      child: Column(
        children: <Widget>[
          const TradingInfo(),
          const SizedBox(height: 10),
          const InitialCap(),
          const SizedBox(height: 10),
          const TradingSetting(),
          const SizedBox(height: 10),
          const TradingInput(),
          Divider(
            height: 24,
            color: Colors.grey.shade800,
            thickness: 2,
          ),
          const Expanded(child: TradeHistory())
        ],
      ),
    );
  }
}

class TradingInfo extends StatelessWidget {
  const TradingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Row(
      children: <Widget>[
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "trade pair",
              inputType: TextInputType.text,
              textFocus: controller.tradingInfoInput.tradingPairFocus.value,
              textFocusOnChange: (newFocus) {
                controller.tradingInfoInput.changeFocus(
                    controller.tradingInfoInput.tradingPairFocus,
                    newFocus,
                    context);
              },
              textController: controller.tradingInfoInput.tradingPairController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.tradingPair,
                newValue,
              ),
              onEditingComplete: () {},
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "timeframe",
              inputType: TextInputType.text,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.timeFrameFocus.value = newFocus,
              textFocus: controller.tradingInfoInput.timeFrameFocus.value,
              textController: controller.tradingInfoInput.timeFrameController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.timeFrame,
                newValue,
              ),
              onEditingComplete: () {},
            ),
          ),
        ),
        const SizedBox(width: 10),
        Obx(
          () => Expanded(
            child: RegularTextfield(
              hint: "duration",
              inputType: TextInputType.text,
              textFocus: controller.tradingInfoInput.durationFocus.value,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.durationFocus.value = newFocus,
              textController: controller.tradingInfoInput.durationController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.duration,
                newValue,
              ),
              onEditingComplete: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class InitialCap extends StatelessWidget {
  const InitialCap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Obx(
      () => RegularTextfield(
        hint: "intial capital",
        inputType: TextInputType.number,
        textFocus: controller.tradingInfoInput.initCapFocus.value,
        textFocusOnChange: (newFocus) =>
            controller.tradingInfoInput.initCapFocus.value = newFocus,
        textController: controller.tradingInfoInput.initCapController,
        onChangeValue: (newValue) => controller.tradingInfoInput.getTradeInput(
          controller.tradingInfoInput.initCap,
          double.tryParse(newValue) ?? 0.0,
        ),
        onEditingComplete: () {},
      ),
    );
  }
}

class TradingSetting extends StatelessWidget {
  const TradingSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Row(
      children: <Widget>[
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "budget %",
              inputType: TextInputType.number,
              textFocus: controller.tradingInfoInput.budgetFocus.value,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.budgetFocus.value = newFocus,
              textController: controller.tradingInfoInput.budgetController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.budget,
                double.tryParse(newValue) ?? 0.0,
              ),
              onEditingComplete: () {},
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "leverage",
              inputType: TextInputType.number,
              textFocus: controller.tradingInfoInput.leverageFocus.value,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.leverageFocus.value = newFocus,
              textController: controller.tradingInfoInput.leverageController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.leverage,
                int.tryParse(newValue) ?? 1,
              ),
              onEditingComplete: () {},
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "fee %",
              inputType: TextInputType.number,
              textFocus: controller.tradingInfoInput.feeFocus.value,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.feeFocus.value = newFocus,
              textController: controller.tradingInfoInput.feeController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.fee,
                double.tryParse(newValue) ?? 0.0,
              ),
              onEditingComplete: () {},
            ),
          ),
        )
      ],
    );
  }
}

class TradingInput extends StatelessWidget {
  const TradingInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Obx(
            () => RegularTextfield(
              hint: "profit loss %",
              inputType: TextInputType.number,
              textFocus: controller.tradingInfoInput.tradePercentageFocus.value,
              textFocusOnChange: (newFocus) => controller
                  .tradingInfoInput.tradePercentageFocus.value = newFocus,
              textController:
                  controller.tradingInfoInput.tradePercentageController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingInfoInput.tradePercentage,
                double.tryParse(newValue) ?? 0.0,
              ),
              onEditingComplete: () => controller.tradingInfoInput.addTrade(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () => RegularFlatButton(
              title: "Add ${controller.tradeController.tradeList.length + 1}",
              bgColor: const Color(0xFF73BA9B),
              onTap: () => controller.tradingInfoInput.addTrade(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RegularFlatButton(
            title: "Remove",
            bgColor: const Color(0xFFEF233C),
            onTap: () => controller.tradingInfoInput.removeTrade(),
          ),
        ),
      ],
    );
  }
}

class TradeHistory extends StatelessWidget {
  const TradeHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Column(
      children: <Widget>[
        const Text("Trade History"),
        Expanded(child: TradeHistoryListview()),
      ],
    );
  }
}
