// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:get/get.dart';
import 'package:simple_trading_strategy_tester/controller/controller.dart';

class TradeHistoryListview extends StatelessWidget {
  TradeHistoryListview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Obx(
      () => controller.tradeController.tradeList.isEmpty
          ? const Center(
              child: Text("List Empty"),
            )
          : SingleChildScrollView(
              controller: controller.tradeController.tradeListScroll,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                  columns: const [
                    DataColumn(label: Text("Budget")),
                    DataColumn(label: Text("Trade Profit/Loss")),
                    DataColumn(label: Text("Fee")),
                    DataColumn(label: Text("Leverage")),
                    DataColumn(label: Text("Changes")),
                    DataColumn(label: Text("Capital")),
                  ],
                  rows: controller.tradeController.tradeList
                      .map(
                        (element) => DataRow(
                          cells: [
                            //* Budget
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                    CurrencyFormatter.format(
                                      element.budget,
                                      CurrencyFormatterSettings(
                                        symbol: 'USD',
                                        symbolSide: SymbolSide.right,
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      "${element.budgetPerccentage.toStringAsFixed(2)}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //* Trade percentage
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                    CurrencyFormatter.format(
                                      element.tradeNominal,
                                      CurrencyFormatterSettings(
                                        symbol: 'USD',
                                        symbolSide: SymbolSide.right,
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                      ),
                                    ),
                                    style: element.tradeNominal >= 0
                                        ? const TextStyle(
                                            color: Colors.greenAccent,
                                          )
                                        : const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        element.tradePercentage >= 0
                                            ? const Icon(
                                                Icons.arrow_drop_up_rounded,
                                                color: Color(0xFF80FFDB),
                                              )
                                            : const Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: Color(0xFFF72585),
                                              ),
                                        Text(
                                          "${element.tradePercentage.toStringAsFixed(2)}%",
                                          style: element.tradePercentage >= 0
                                              ? const TextStyle(
                                                  color: Colors.greenAccent,
                                                )
                                              : const TextStyle(
                                                  color: Colors.redAccent,
                                                ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //* Fee
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                    CurrencyFormatter.format(
                                      element.feeNominal,
                                      CurrencyFormatterSettings(
                                        symbol: 'USD',
                                        symbolSide: SymbolSide.right,
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      "- ${element.feePercentage.toStringAsFixed(2)}%",
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //* Leverage
                            DataCell(
                              Text("x${element.leverage}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            //* Changes Capital
                            DataCell(
                              Text(
                                CurrencyFormatter.format(
                                  element.changes,
                                  CurrencyFormatterSettings(
                                    symbol: 'USD',
                                    symbolSide: SymbolSide.right,
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                  ),
                                ),
                                style: element.changes >= 0
                                    ? const TextStyle(
                                        color: Colors.greenAccent,
                                      )
                                    : const TextStyle(
                                        color: Colors.redAccent,
                                      ),
                              ),
                            ),
                            //* Capital
                            DataCell(
                              Text(
                                CurrencyFormatter.format(
                                  element.cap,
                                  CurrencyFormatterSettings(
                                    symbol: 'USD',
                                    symbolSide: SymbolSide.right,
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}

class IndicatorListview extends StatelessWidget {
  const IndicatorListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.put(AppController());
    return Obx(
      () => controller.tradingIndicator.indicatorList.isEmpty
          ? const Center(
              child: Text("No indicator"),
            )
          : ListView.builder(
              controller: ScrollController(),
              itemCount: controller.tradingIndicator.indicatorList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(
                    controller
                        .tradingIndicator.indicatorList[index].indicatorName
                        .toUpperCase(),
                  ),
                  subtitle: Text(
                    controller
                        .tradingIndicator.indicatorList[index].indicatorDesc,
                  ),
                  trailing: IconButton(
                    onPressed: () =>
                        controller.tradingIndicator.removeIndicator(index),
                    icon: const Icon(Icons.delete_rounded),
                  ),
                );
              },
            ),
    );
  }
}
