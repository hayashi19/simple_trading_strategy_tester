import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_formatter/currency_formatter.dart';

import 'package:simple_trading_strategy_tester/controller/controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text(
          "Trade History",
          style: TextStyle(fontSize: 20),
        ),
        TradeHistory(),
      ],
    );
  }
}

class TradeHistory extends StatelessWidget {
  const TradeHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TradeController controller = Get.put(TradeController());
    return Flexible(
      child: SingleChildScrollView(
        controller: controller.tradeListScroll,
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => DataTable(
              headingTextStyle: TextStyle(
                color: Colors.grey.shade300,
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    "Budget",
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Trade Profit/Loss",
                  ),
                ),
                DataColumn(
                  label: Text("Fee"),
                ),
                DataColumn(
                  label: Text("Leverage"),
                ),
                DataColumn(
                  label: Text(
                    "Changes",
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Capital",
                  ),
                ),
              ],
              rows: controller.tradeList
                  .map(
                    (element) => DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Text(
                                CurrencyFormatter().format(
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
                        DataCell(
                          Row(
                            children: [
                              Text(
                                CurrencyFormatter().format(
                                  element.tradeNominal,
                                  CurrencyFormatterSettings(
                                    symbol: 'USD',
                                    symbolSide: SymbolSide.right,
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                  ),
                                ),
                                style: element.tradeNominal > 0
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
                                    element.tradeNominal > 0
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
                                      style: element.tradePercentage > 0
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
                        DataCell(
                          Row(
                            children: [
                              Text(
                                CurrencyFormatter().format(
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
                        DataCell(
                          Text("x${element.leverage}",
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        DataCell(
                          Text(
                              CurrencyFormatter().format(
                                element.changes,
                                CurrencyFormatterSettings(
                                  symbol: 'USD',
                                  symbolSide: SymbolSide.right,
                                  thousandSeparator: '.',
                                  decimalSeparator: ',',
                                ),
                              ),
                              style: element.changes > 0
                                  ? const TextStyle(
                                      color: Colors.greenAccent,
                                    )
                                  : const TextStyle(
                                      color: Colors.redAccent,
                                    )),
                        ),
                        DataCell(
                          Text(
                            CurrencyFormatter().format(
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
      ),
    );
  }
}
