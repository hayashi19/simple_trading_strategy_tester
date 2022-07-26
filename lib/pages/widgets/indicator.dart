import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';

class IndicatorPage extends StatelessWidget {
  const IndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Flexible(child: IndicatorTitle()),
            SizedBox(width: 10),
            AddIndicatorButton(),
          ],
        ),
        const SizedBox(height: 10),
        const IndicatorDesc(),
        const SizedBox(height: 10),
        const Flexible(child: IndicatorList())
      ],
    );
  }
}

class IndicatorTitle extends StatelessWidget {
  const IndicatorTitle({Key? key}) : super(key: key);

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
              controller: controller.indicatorTitleController_indicator,
              decoration: const InputDecoration.collapsed(
                hintText: "indicator title / name",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorDesc extends StatelessWidget {
  const IndicatorDesc({Key? key}) : super(key: key);

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
              controller: controller.indicatorDescController_indicator,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 2,
              decoration: const InputDecoration.collapsed(
                hintText: "indicator description",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddIndicatorButton extends StatelessWidget {
  const AddIndicatorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(20),
        ),
      ),
      onPressed: () => controller.addIndicator(),
      icon: const Icon(Icons.add_rounded),
      label: const Text(
        "Add Indicator",
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class IndicatorList extends StatelessWidget {
  const IndicatorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.find();
    return Obx(
      () => ListView.builder(
        controller: ScrollController(),
        itemCount: controller.indicatorList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text((index + 1).toString()),
            title: Text(
                controller.indicatorList[index].indicatorName.toUpperCase()),
            subtitle: Text(controller.indicatorList[index].indicatorDesc),
            trailing: IconButton(
              onPressed: () => controller.removeIndicator(index),
              icon: const Icon(Icons.delete_rounded),
            ),
          );
        },
      ),
    );
  }
}
