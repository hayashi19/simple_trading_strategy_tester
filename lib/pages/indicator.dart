import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';
import 'package:simple_trading_strategy_tester/widgets/c_button.dart';
import 'package:simple_trading_strategy_tester/widgets/c_listview.dart';
import 'package:simple_trading_strategy_tester/widgets/c_textfield.dart';

class IndicatorPage extends StatelessWidget {
  const IndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          const IndicatorTitleTextfield(),
          const SizedBox(height: 10),
          const IndicatorDescTextfield(),
          Divider(
            color: Colors.grey.shade800,
            height: 24,
            thickness: 2,
          ),
          const Expanded(child: IndicatorListview())
        ],
      ),
    );
  }
}

class IndicatorTitleTextfield extends StatelessWidget {
  const IndicatorTitleTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Row(
      children: <Widget>[
        Expanded(
          child: Obx(
            () => RegularTextfield(
              hint: "Indicator title",
              inputType: TextInputType.text,
              textFocus: controller.tradingIndicator.indicatorTitleFocus.value,
              textFocusOnChange: (newFocus) =>
                  controller.tradingInfoInput.changeFocus(
                controller.tradingIndicator.indicatorTitleFocus,
                newFocus,
                context,
              ),
              textController:
                  controller.tradingIndicator.indicatorTitleController,
              onChangeValue: (newValue) =>
                  controller.tradingInfoInput.getTradeInput(
                controller.tradingIndicator.indicatorTitle,
                newValue,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        RegularFlatButton(
          title: "Add",
          bgColor: Colors.grey.shade800,
          onTap: () => controller.tradingIndicator.addIndicator(),
        ),
      ],
    );
  }
}

class IndicatorDescTextfield extends StatelessWidget {
  const IndicatorDescTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Obx(
      () => RegularTextfield(
        hint: "Indicator description",
        inputType: TextInputType.multiline,
        minLine: 1,
        maxLine: 4,
        textFocus: controller.tradingIndicator.indicatorDescFocus.value,
        textFocusOnChange: (newFocus) =>
            controller.tradingInfoInput.changeFocus(
          controller.tradingIndicator.indicatorDescFocus,
          newFocus,
          context,
        ),
        textController: controller.tradingIndicator.indicatorDescController,
        onChangeValue: (newValue) => controller.tradingInfoInput.getTradeInput(
          controller.tradingIndicator.indicatorDesc,
          newValue,
        ),
      ),
    );
  }
}
