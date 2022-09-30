// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, deprecated_member_use, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:list_ext/list_ext.dart';

import 'package:simple_trading_strategy_tester/controller/list_model.dart';

class TradeController extends GetxController {
  var test = "".obs;
  var strategyList = <StrategyListModel>[].obs;
  var strategyIndex = (-1).obs;

  var tradeList = <TradingListModel>[].obs;
  var strategyTitleController_info = TextEditingController();
  var strategyTitle_info = "".obs;
  var tradingPairController_info = TextEditingController();
  var tradingPair_info = "".obs;
  var timeFrameController_info = TextEditingController();
  var timeFrame_info = "".obs;
  var durationController_info = TextEditingController();
  var duration_info = "".obs;
  var initCapController_info = TextEditingController();
  var initCap_info = 0.0.obs;
  var budgetController_trade = TextEditingController();
  var budget_trade = 0.0.obs;
  var leverageController_trade = TextEditingController();
  var leverage_trade = 1.obs;
  var feeController_trade = TextEditingController();
  var fee_trade = 0.0.obs;
  var tradePercentageController_trade = TextEditingController();
  var tradePercentage_trade = 0.0.obs;

  var tradeListScroll = ScrollController();

  Future<void> getStrategyTitle() async {
    try {
      strategyTitle_info.value = strategyTitleController_info.text;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTradingPair() async {
    try {
      tradingPair_info.value = tradingPairController_info.text;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTimeframe() async {
    try {
      timeFrame_info.value = timeFrameController_info.text;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getDuration() async {
    try {
      duration_info.value = durationController_info.text;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getInitCap() async {
    try {
      initCap_info.value = double.tryParse(initCapController_info.text) ?? 0.0;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getBudget() async {
    try {
      budget_trade.value = double.tryParse(budgetController_trade.text) ?? 0.0;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getLeverage() async {
    try {
      leverage_trade.value = int.tryParse(leverageController_trade.text) ?? 1;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFee() async {
    try {
      fee_trade.value = double.tryParse(feeController_trade.text) ?? 0.0;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTradePercentage() async {
    try {
      tradePercentage_trade.value =
          double.tryParse(tradePercentageController_trade.text) ?? 0.0;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addTrade() async {
    try {
      var initCap = initCap_info.value;

      var leverage = leverage_trade.value;

      var budgetPercentage = budget_trade.value;
      var budgetNominal = tradeList.isEmpty
          ? ((initCap * (budgetPercentage / 100)) * leverage)
          : ((tradeList.last.cap * (budgetPercentage / 100)) * leverage);

      var tradePercentage = tradePercentage_trade.value;
      var tradeNominal = budgetNominal * (tradePercentage / 100);

      var feePercentage = fee_trade.value;
      var feeNominal = budgetNominal * (feePercentage / 100);

      var changes = tradeNominal - feeNominal;
      var cap = tradeList.isEmpty
          ? initCap_info.value + changes
          : tradeList.last.cap + changes;
      tradeList.add(
        TradingListModel(
          tradePercentage: tradePercentage,
          tradeNominal: tradeNominal,
          feePercentage: feePercentage,
          feeNominal: feeNominal,
          leverage: leverage.toDouble(),
          changes: changes,
          cap: cap,
          budget: budgetNominal,
          budgetPerccentage: budgetPercentage,
        ),
      );
      tradePercentageController_trade.clear();
      tradePercentage_trade.value = 0;
      tradeListScroll.animateTo(tradeListScroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeTrade() async {
    try {
      tradeList.isNotEmpty ? tradeList.removeLast() : null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editTrade(String changeInfo) async {
    try {
      if (tradeList.isNotEmpty) {
        for (var i = 0; i < tradeList.length; i++) {
          debugPrint("ASDASDASDASDASDASDSADASD");
          var initCap = initCap_info.value;

          var leverage = leverage_trade.value;

          var budgetPercentage = budget_trade.value;

          var budgetNominal = i < 1
              ? ((initCap * (budgetPercentage / 100)) * leverage)
              : ((tradeList[i - 1].cap * (budgetPercentage / 100)) * leverage);

          var tradePercentage = tradeList[i].tradePercentage;
          var tradeNominal = budgetNominal * (tradePercentage / 100);

          var feePercentage = fee_trade.value;
          var feeNominal = budgetNominal * (feePercentage / 100);

          var changes = tradeNominal - feeNominal;
          var cap = i < 1 ? initCap + changes : tradeList[i - 1].cap + changes;

          tradeList[i] = TradingListModel(
            tradePercentage: tradePercentage,
            tradeNominal: tradeNominal,
            feePercentage: feePercentage,
            feeNominal: feeNominal,
            leverage: leverage.toDouble(),
            changes: changes,
            cap: cap,
            budget: budgetNominal,
            budgetPerccentage: budgetPercentage,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Fee
  var totalFee = 0.0.obs;
  var averageFee = 0.0.obs;

  // Total profit loss
  var grossProfit = 0.0.obs;
  var grossLoss = 0.0.obs;
  var netoProfit = 0.0.obs;
  var profitFactor = 0.0.obs;

  // Capital
  var finalCap = 0.0.obs;
  var totalVolume = 0.0.obs;
  var gain = 0.0.obs;

  // Trade & winrate
  var winTrade = 0.obs;
  var loseTrade = 0.obs;
  var totalTrade = 0.obs;
  var winrate = 100.0.obs;
  var consecutiveWin = 0.obs; // N
  var consecutiveLoss = 0.obs; // N

  // Largest trade
  var largestWinNominal = 0.0.obs;
  var largestLossNominal = 0.0.obs;
  var largestWinPercentage = 0.0.obs;
  var largestLossPercentage = 0.0.obs;

  // Average Trade
  var averageWinNominal = 0.0.obs;
  var averageLossNominal = 0.0.obs;
  var averageWinPercentage = 0.0.obs;
  var averageLossPercentage = 0.0.obs;
  var averageRatio = 0.0.obs; //N

  // Trade Factor
  var high = 0.0.obs;
  var highIndex = 0.obs; //N
  var low = 0.0.obs;
  var lowIndex = 0.obs; //N
  var lowAfterHigh = 0.obs; //N
  var highAfterlow = 0.obs; //N
  var runUpSequance = <Possibility>[].obs; // N
  // var runUpSequancePercentage = [].obs; // N
  var maxRunUpPercentage = 0.0.obs; // N
  var drawDownSequance = <Possibility>[].obs; //N
  // var drawDownSequancePercentage = [].obs; //N
  var maxDrawdownPercentage = 0.0.obs; //N

  Future<void> getPerformance_perf() async {
    try {
      // Total profit loss
      await Future<double>.sync(
        () => tradeList.sumOfDouble((element) => element.feeNominal),
      ).then(
        (value) => totalFee.value = value,
      );
      await Future<double>.sync(
        () => tradeList.avgOfDouble((element) => element.feeNominal),
      ).then((value) => averageFee.value = value);

      // Total profit loss
      await Future<double>.sync(
        () => tradeList.sumOfDouble(
          (element) => element.tradeNominal > 0 ? element.tradeNominal : 0,
        ),
      ).then((value) => grossProfit.value = value);
      await Future<double>.sync(
        () => tradeList.sumOfDouble(
          (element) => element.tradeNominal < 0 ? element.tradeNominal : 0,
        ),
      ).then((value) => grossLoss.value = value);
      await Future.sync(
        () => grossProfit.value - grossLoss.value - totalFee.value,
      ).then((value) => netoProfit.value = value);
      await Future<double>.sync(
        () => grossLoss.value == 0 ? 1 : -(grossProfit.value / grossLoss.value),
      ).then((value) => profitFactor.value = value);

      // Capital
      await Future<double>.sync(
        () => tradeList.isNotEmpty ? tradeList.last.cap : 0.0,
      ).then((value) => finalCap.value = value);
      await Future<double>.sync(
        () => tradeList.sumOfDouble((element) => element.budget),
      ).then((value) => totalVolume.value = value);
      await Future<double>.sync(
        () =>
            ((finalCap.value - initCap_info.value) / initCap_info.value) * 100,
      ).then((value) => gain.value = value);

      // Trade & winrate
      await Future<int>.sync(
        () => tradeList.countWhere((element) => element.tradeNominal > 0),
      ).then((value) => winTrade.value = value);
      await Future<int>.sync(
        () => tradeList.countWhere((element) => element.tradeNominal < 0),
      ).then((value) => loseTrade.value = value);
      await Future<int>.sync(
        () => tradeList.length,
      ).then((value) => totalTrade.value = value);
      await Future<double>.sync(
        () =>
            tradeList.isEmpty ? 100 : (winTrade.value / totalTrade.value) * 100,
      ).then((value) => winrate.value = value);
      await Future.sync(() {
        var tempA = 0;
        var tempB = 0;
        for (var element in tradeList) {
          if (element.tradeNominal >= 0) {
            tempA++;
          } else if (element.tradeNominal < 0) {
            if (tempA > tempB) {
              tempB = tempA;
            }
            tempA = 0;
          }
        }
        if (tempA > tempB) {
          tempB = tempA;
        }
        tempA = 0;
        return tempB;
      }).then((value) => consecutiveWin.value = value);
      await Future.sync(() async {
        var tempA = 0;
        var tempB = 0;
        for (var element in tradeList) {
          if (element.tradeNominal < 0) {
            tempA++;
          } else if (element.tradeNominal >= 0) {
            if (tempA > tempB) {
              tempB = tempA;
            }
            tempA = 0;
          }
        }
        if (tempA > tempB) {
          tempB = tempA;
        }
        tempA = 0;
        return tempB;
      }).then((value) => consecutiveLoss.value = value);

      // Largest trade
      await Future<double>.sync(
        () => tradeList.maxOf(
            (element) => element.tradeNominal > 0 ? element.tradeNominal : 0),
      ).then((value) => largestWinNominal.value = value); // N
      await Future<double>.sync(
        () => tradeList.minOf(
            (element) => element.tradeNominal < 0 ? element.tradeNominal : 0),
      ).then((value) => largestLossNominal.value = value); // N
      await Future<double>.sync(
        () => tradeList.maxOf((element) =>
            element.tradePercentage > 0 ? element.tradePercentage : 0),
      ).then((value) => largestWinPercentage.value = value); // N
      await Future<double>.sync(
        () => tradeList.minOf((element) =>
            element.tradePercentage < 0 ? element.tradePercentage : 0),
      ).then((value) => largestLossPercentage.value = value); // N

      // Average Trade
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradeList.sumOfDouble((element) =>
                    element.tradeNominal > 0 ? element.tradeNominal : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinNominal.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradeList.sumOfDouble((element) =>
                    element.tradeNominal < 0 ? element.tradeNominal : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossNominal.value = value);
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradeList.sumOfDouble((element) =>
                    element.tradePercentage > 0 ? element.tradePercentage : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinPercentage.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradeList.sumOfDouble((element) =>
                    element.tradePercentage < 0 ? element.tradePercentage : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossPercentage.value = value);
      await Future<double>.sync(
        () => averageWinNominal.value / averageLossNominal.value,
      ).then((value) => averageRatio.value = value);

      // Trade Factor
      await Future<double>.sync(
        () => tradeList.maxOf((element) => element.cap),
      ).then((value) => high.value = value);
      await Future<int>.sync(
        () => tradeList.map((e) => e.cap).toList().indexOf(high.value),
      ).then((value) => highIndex.value = value);
      await Future<double>.sync(
        () => initCap_info.value < low.value
            ? initCap_info.value
            : tradeList.minOf((element) => element.cap),
      ).then((value) => low.value = value);
      await Future<int>.sync(
        () => tradeList.map((e) => e.cap).toList().indexOf(low.value),
      ).then((value) => lowIndex.value = value);

      lowAfterHigh.value = 0;
      highAfterlow.value = 0;

      Future.sync(() {
        runUpSequance.value = [];
        maxRunUpPercentage.value = 0.0;
        List tempList = [];
        double getLast = tradeList.last.cap;
        for (var i = 0; i < tradeList.length; i++) {
          if (i < 1) {
            tempList.add(tradeList[i].cap);
          } else {
            if (getLast != tradeList[i].cap) {
              if (tradeList[i].cap < tradeList[i - 1].cap &&
                  tradeList[i].cap < tradeList[i + 1].cap) {
                tempList.add(tradeList[i].cap);
              }
            }
            if (tradeList[i].cap > tradeList[i - 1].cap) {
              tempList.add(tradeList[i].cap);
            }
            if (getLast != tradeList[i].cap) {
              if (tradeList[i].cap > tradeList[i + 1].cap) {
                if (tempList.isNotEmpty) {
                  runUpSequance.add(
                    Possibility(
                      maxSequance: tempList,
                      maxSequancePercentage: 1,
                    ),
                  );
                }
                tempList = [];
              }
            }
          }
        }
        return runUpSequance.value;
      }).then((value) {
        Future.sync(() {
          for (var i = 0; i < value.length; i++) {
            value[i] = Possibility(
              maxSequance: value[i].maxSequance,
              maxSequancePercentage:
                  ((value[i].maxSequance.last - value[i].maxSequance.first) /
                          value[i].maxSequance.first) *
                      100,
            );
          }
          return runUpSequance.value;
        }).then((value) => maxRunUpPercentage.value =
            runUpSequance.maxOf((element) => element.maxSequancePercentage));
      });

      Future.sync(() {
        drawDownSequance.value = [];
        maxDrawdownPercentage.value = 0.0;
        List tempList = [];
        double getLast = tradeList.last.cap;
        for (var i = 0; i < tradeList.length; i++) {
          if (i < 1) {
            tempList.add(tradeList[i].cap);
          } else {
            if (getLast != tradeList[i].cap) {
              if (tradeList[i].cap > tradeList[i - 1].cap &&
                  tradeList[i].cap > tradeList[i + 1].cap) {
                tempList.add(tradeList[i].cap);
              }
            }
            if (tradeList[i].cap < tradeList[i - 1].cap) {
              tempList.add(tradeList[i].cap);
            }
            if (getLast != tradeList[i].cap) {
              if (tradeList[i].cap < tradeList[i + 1].cap) {
                if (tempList.isNotEmpty) {
                  drawDownSequance.add(
                    Possibility(
                      maxSequance: tempList,
                      maxSequancePercentage: 1,
                    ),
                  );
                }
                tempList = [];
              }
            }
          }
        }
        return drawDownSequance.value;
      }).then((value) {
        Future.sync(() {
          for (var i = 0; i < value.length; i++) {
            value[i] = Possibility(
              maxSequance: value[i].maxSequance,
              maxSequancePercentage:
                  ((value[i].maxSequance.last - value[i].maxSequance.first) /
                          value[i].maxSequance.first) *
                      100,
            );
          }
          return value;
        }).then((value) => maxDrawdownPercentage.value =
            drawDownSequance.minOf((element) => element.maxSequancePercentage));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var indicatorList = <IndicatorListModel>[].obs;
  var indicatorTitleController_indicator = TextEditingController();
  var indicatorTitle_indicator = 0.0.obs;
  var indicatorDescController_indicator = TextEditingController();
  var indicatorDesc_indicator = 0.0.obs;

  Future<void> addIndicator() async {
    try {
      indicatorList.add(
        IndicatorListModel(
          indicatorName: indicatorTitleController_indicator.text,
          indicatorDesc: indicatorDescController_indicator.text,
        ),
      );
      indicatorTitleController_indicator.clear();
      indicatorDescController_indicator.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeIndicator(int index) async {
    try {
      indicatorList.removeAt(index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveStrategy() async {
    try {
      ever(strategyList, (_) {
        GetStorage().write('strategies', strategyList.toList());
        debugPrint("Strategy saved ${strategyList.length}");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getSavedStrategy() async {
    try {
      List? storedPw = GetStorage().read<List>('strategies');
      if (!storedPw.isNull) {
        strategyList.value =
            storedPw!.map((e) => StrategyListModel.fromJson(e)).toList();
      }

      debugPrint("Get saved strategy ${strategyList.length}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setStrategy() async {
    try {
      if (strategyIndex != -1) {
        strategyList[strategyIndex.value] = StrategyListModel(
          strategyTitle: strategyTitle_info.value,
          duration: duration_info.value,
          // startDate: "",
          // endDate: "",
          initCap: initCap_info.value,
          gain: gain.value,
          winrate: winrate.value,
          // currency: "",
          tradingPair: tradingPair_info.value,
          timeframe: timeFrame_info.value,
          indicator: indicatorList.value,
          trade: tradeList.value,
        );
      } else {
        strategyList.add(
          StrategyListModel(
            strategyTitle: strategyTitle_info.value,
            duration: duration_info.value,
            // startDate: "",
            // endDate: "",
            initCap: initCap_info.value,
            gain: gain.value,
            winrate: winrate.value,
            // currency: "",
            tradingPair: tradingPair_info.value,
            timeframe: timeFrame_info.value,
            indicator: indicatorList.value,
            trade: tradeList.value,
          ),
        );
      }

      // Future.delayed(Duration(seconds: 1), () {
      strategyTitleController_info.clear();
      strategyTitle_info.value = "";
      tradingPairController_info.clear();
      tradingPair_info.value = "";
      timeFrameController_info.clear();
      timeFrame_info.value = "";
      initCapController_info.clear();
      initCap_info.value = 0.0;
      budgetController_trade.clear();
      budget_trade.value = 0.0;
      leverageController_trade.clear();
      leverage_trade.value = 1;
      feeController_trade.clear();
      fee_trade.value = 0.0;
      tradePercentageController_trade.clear();
      tradePercentage_trade.value = 0.0;

      tradeList.value = [];
      indicatorList.value = [];
      // Fee
      totalFee.value = 0.0;
      averageFee.value = 0.0;

      // Total profit loss
      grossProfit.value = 0.0;
      grossLoss.value = 0.0;
      netoProfit.value = 0.0;
      profitFactor.value = 0.0;

      // Capital
      finalCap.value = 0.0;
      totalVolume.value = 0.0;
      gain.value = 0.0;

      // Trade & winrate
      winTrade.value = 0;
      loseTrade.value = 0;
      totalTrade.value = 0;
      winrate.value = 100.0;
      consecutiveWin.value = 0; // N
      consecutiveLoss.value = 0; // N

      // Largest trade
      largestWinNominal.value = 0.0;
      largestLossNominal.value = 0.0;
      largestWinPercentage.value = 0.0;
      largestLossPercentage.value = 0.0;

      // Average Trade
      averageWinNominal.value = 0.0;
      averageLossNominal.value = 0.0;
      averageWinPercentage.value = 0.0;
      averageLossPercentage.value = 0.0;
      averageRatio.value = 0.0; //N

      // Trade Factor
      high.value = 0.0;
      highIndex.value = 0; //N
      low.value = 0.0;
      lowIndex.value = 0; //N
      lowAfterHigh.value = 0; //N
      highAfterlow.value = 0; //N
      runUpSequance.value = []; // N
      // var runUpSequancePercentage = [].obs; // N
      maxRunUpPercentage.value = 0.0; // N
      drawDownSequance.value = []; //N
      // var drawDownSequancePercentage = [].obs; //N
      maxDrawdownPercentage.value = 0.0; //N
      // });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStrategy(int index) async {
    try {
      strategyIndex.value = index;

      strategyTitle_info.value = strategyList[index].strategyTitle;
      strategyTitleController_info.text = strategyList[index].strategyTitle;

      tradingPair_info.value = strategyList[index].tradingPair;
      tradingPairController_info.text = strategyList[index].tradingPair;

      timeFrame_info.value = strategyList[index].timeframe;
      timeFrameController_info.text = strategyList[index].timeframe;

      duration_info.value = strategyList[index].duration;
      durationController_info.text = strategyList[index].duration;

      initCap_info.value = strategyList[index].initCap;
      initCapController_info.text = strategyList[index].initCap.toString();

      budget_trade.value = strategyList[index].trade.last.budgetPerccentage;
      budgetController_trade.text =
          strategyList[index].trade.last.budgetPerccentage.toString();

      leverage_trade.value = strategyList[index].trade.last.leverage.toInt();
      leverageController_trade.text =
          strategyList[index].trade.last.leverage.toString();

      fee_trade.value = strategyList[index].trade.last.feePercentage;
      feeController_trade.text =
          strategyList[index].trade.last.feePercentage.toString();

      tradePercentage_trade.value =
          strategyList[index].trade.last.tradePercentage;
      tradePercentageController_trade.text =
          strategyList[index].trade.last.tradePercentage.toString();

      tradeList.value = strategyList[index].trade;
      test.value = strategyList[index].trade.toString();
      indicatorList.value = strategyList[index].indicator;

      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeStrategy(int index) async {
    try {
      strategyList.removeAt(index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final BannerAd listBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  late InterstitialAd interstitialAd;
  var adIsLoaded = false.obs;

  Future loadInterstitialAd() async {
    try {
      InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            adIsLoaded.value = true;
            debugPrint(
                "ADS LOADED ADS LOADED ADS LOADED ADS LOADED ADS LOADED");
            interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              adIsLoaded.value = false;
              interstitialAd.dispose();
              Get.back();
            }, onAdFailedToShowFullScreenContent: (ad, error) {
              adIsLoaded.value = false;
              interstitialAd.dispose();
              Get.back();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    saveStrategy();
    getSavedStrategy();

    listBanner.load();
    loadInterstitialAd();
    try {
      ever(tradeList, (_) {
        if (tradeList.isNotEmpty) {
          getPerformance_perf();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    super.onInit();
  }
}
