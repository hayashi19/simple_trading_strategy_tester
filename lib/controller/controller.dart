// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, deprecated_member_use, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:list_ext/list_ext.dart';

import 'package:simple_trading_strategy_tester/controller/list_model.dart';

class AppController extends GetxController {
  final TradeController tradeController = Get.put(TradeController());
  final TradingInfo tradingInfoInput = Get.put(TradingInfo());
  final TradingCalculation tradingCalculation = Get.put(TradingCalculation());
  final TradingIndicator tradingIndicator = Get.put(TradingIndicator());
  final AdsController adsController = Get.put(AdsController());

  @override
  void onInit() {
    tradingInfoInput.initCapController.text = 100.toString();
    tradingInfoInput.initCap.value = 100.toDouble();

    tradeController.saveStrategy();
    tradeController.getSavedStrategy();

    adsController.listBanner.load();
    adsController.loadInterstitialAd();
    try {
      ever(tradeController.tradeList, (_) {
        if (tradeController.tradeList.isNotEmpty) {
          final TradingCalculation tradingCalculation =
              Get.put(TradingCalculation());
          tradingCalculation.getPerformance_perf();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    super.onInit();
  }
}

class TradingInfo extends GetxController {
  //* Title
  var strategyTitleController = TextEditingController();
  var strategyTitleFocus = false.obs;
  var strategyTitle = "".obs;

  //* Trading Pair
  var tradingPairController = TextEditingController();
  var tradingPairFocus = false.obs;
  var tradingPair = "".obs;

  //* Timeframe
  var timeFrameController = TextEditingController();
  var timeFrameFocus = false.obs;
  var timeFrame = "".obs;

  //* Duration
  var durationController = TextEditingController();
  var durationFocus = false.obs;
  var duration = "".obs;

  //* Initial Capital
  var initCapController = TextEditingController();
  var initCapFocus = false.obs;
  var initCap = 0.0.obs;

  //* Budget Percentage
  var budgetController = TextEditingController();
  var budgetFocus = false.obs;
  var budget = 0.0.obs;

  //* Leverage
  var leverageController = TextEditingController();
  var leverageFocus = false.obs;
  var leverage = 1.obs;

  //* Fee Percentage
  var feeController = TextEditingController();
  var feeFocus = false.obs;
  var fee = 0.0.obs;

  //* Profit Loss Percentage
  var tradePercentageController = TextEditingController();
  var tradePercentageFocus = false.obs;
  var tradePercentage = 0.0.obs;

  void getTradeInput(Rx value, var newValue) {
    try {
      value.value = newValue;
    } catch (e) {
      Get.defaultDialog(
        titleStyle: const TextStyle(color: Colors.redAccent),
        content: Text(e.toString()),
        confirm: Ink(
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Close"),
            ),
          ),
        ),
      );
    }
  }

  void changeFocus(Rx value, var newFocus, BuildContext context) {
    try {
      value.value = newFocus;
    } catch (e) {
      Get.defaultDialog(
        titleStyle: const TextStyle(color: Colors.redAccent),
        content: Text(e.toString()),
        confirm: Ink(
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Close"),
            ),
          ),
        ),
      );
    }
  }

  Future<void> addTrade() async {
    final TradeController tradeController = Get.put(TradeController());
    try {
      initCap.value = double.tryParse(initCapController.text) ?? 0.0;
      budget.value = double.tryParse(budgetController.text) ?? 0.0;
      leverage.value = int.tryParse(leverageController.text) ?? 1;
      fee.value = double.tryParse(feeController.text) ?? 0.0;
      tradePercentage.value =
          double.tryParse(tradePercentageController.text) ?? 0.0;

      var _initCap = initCap.value;
      var _leverage = leverage.value;
      var _budgetPercentage = budget.value;
      var _budgetNominal = tradeController.tradeList.isEmpty
          ? ((_initCap * (_budgetPercentage / 100)) * _leverage)
          : ((tradeController.tradeList.last.cap * (_budgetPercentage / 100)) *
              _leverage);
      var _tradePercentage = tradePercentage.value;
      var _tradeNominal = _budgetNominal * (_tradePercentage / 100);
      var _feePercentage = fee.value;
      var _feeNominal = _budgetNominal * (_feePercentage / 100);
      var _changes = _tradeNominal - _feeNominal;
      var _cap = tradeController.tradeList.isEmpty
          ? initCap.value + _changes
          : tradeController.tradeList.last.cap + _changes;

      tradeController.tradeList.add(
        TradingListModel(
          tradePercentage: _tradePercentage,
          tradeNominal: _tradeNominal,
          feePercentage: _feePercentage,
          feeNominal: _feeNominal,
          leverage: _leverage.toDouble(),
          changes: _changes,
          cap: _cap,
          budget: _budgetNominal,
          budgetPerccentage: _budgetPercentage,
        ),
      );

      tradePercentageController.clear();
      tradePercentage.value = 0;
      tradeController.tradeListScroll.animateTo(
        tradeController.tradeListScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeTrade() async {
    final TradeController tradeController = Get.put(TradeController());
    try {
      tradeController.tradeList.isNotEmpty
          ? tradeController.tradeList.removeLast()
          : null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editTrade(String changeInfo) async {
    final TradeController tradeController = Get.put(TradeController());
    try {
      if (tradeController.tradeList.isNotEmpty) {
        for (var i = 0; i < tradeController.tradeList.length; i++) {
          var _initCap = initCap.value;
          var _leverage = leverage.value;
          var _budgetPercentage = budget.value;
          var _budgetNominal = i < 1
              ? ((_initCap * (_budgetPercentage / 100)) * _leverage)
              : ((tradeController.tradeList[i - 1].cap *
                      (_budgetPercentage / 100)) *
                  _leverage);
          var _tradePercentage = tradeController.tradeList[i].tradePercentage;
          var _tradeNominal = _budgetNominal * (_tradePercentage / 100);
          var _feePercentage = fee.value;
          var _feeNominal = _budgetNominal * (_feePercentage / 100);
          var _changes = _tradeNominal - _feeNominal;
          var _cap = i < 1
              ? _initCap + _changes
              : tradeController.tradeList[i - 1].cap + _changes;

          tradeController.tradeList[i] = TradingListModel(
            tradePercentage: _tradePercentage,
            tradeNominal: _tradeNominal,
            feePercentage: _feePercentage,
            feeNominal: _feeNominal,
            leverage: _leverage.toDouble(),
            changes: _changes,
            cap: _cap,
            budget: _budgetNominal,
            budgetPerccentage: _budgetPercentage,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class TradingCalculation extends GetxController {
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
    final TradeController tradeController = Get.put(TradeController());
    final TradingInfo tradingInfoInput = Get.put(TradingInfo());
    try {
      // Total profit loss
      await Future<double>.sync(
        () => tradeController.tradeList
            .sumOfDouble((element) => element.feeNominal),
      ).then(
        (value) => totalFee.value = value,
      );
      await Future<double>.sync(
        () => tradeController.tradeList
            .avgOfDouble((element) => element.feeNominal),
      ).then((value) => averageFee.value = value);

      // Total profit loss
      await Future<double>.sync(
        () => tradeController.tradeList.sumOfDouble(
          (element) => element.tradeNominal > 0 ? element.tradeNominal : 0,
        ),
      ).then((value) => grossProfit.value = value);
      await Future<double>.sync(
        () => tradeController.tradeList.sumOfDouble(
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
        () => tradeController.tradeList.isNotEmpty
            ? tradeController.tradeList.last.cap
            : 0.0,
      ).then((value) => finalCap.value = value);
      await Future<double>.sync(
        () =>
            tradeController.tradeList.sumOfDouble((element) => element.budget),
      ).then((value) => totalVolume.value = value);
      await Future<double>.sync(
        () =>
            ((finalCap.value - tradingInfoInput.initCap.value) /
                tradingInfoInput.initCap.value) *
            100,
      ).then((value) => gain.value = value);

      // Trade & winrate
      await Future<int>.sync(
        () => tradeController.tradeList
            .countWhere((element) => element.changes >= 0),
      ).then((value) => winTrade.value = value);
      await Future<int>.sync(
        () => tradeController.tradeList
            .countWhere((element) => element.changes < 0),
      ).then((value) => loseTrade.value = value);
      await Future<int>.sync(
        () => tradeController.tradeList.length,
      ).then((value) => totalTrade.value = value);
      await Future<double>.sync(
        () => tradeController.tradeList.isEmpty
            ? 100
            : (winTrade.value / totalTrade.value) * 100,
      ).then((value) => winrate.value = value);
      await Future.sync(() {
        var tempA = 0;
        var tempB = 0;
        for (var element in tradeController.tradeList) {
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
        for (var element in tradeController.tradeList) {
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
        () => tradeController.tradeList.maxOf(
            (element) => element.tradeNominal > 0 ? element.tradeNominal : 0),
      ).then((value) => largestWinNominal.value = value); // N
      await Future<double>.sync(
        () => tradeController.tradeList.minOf(
            (element) => element.tradeNominal < 0 ? element.tradeNominal : 0),
      ).then((value) => largestLossNominal.value = value); // N
      await Future<double>.sync(
        () => tradeController.tradeList.maxOf((element) =>
            element.tradePercentage > 0 ? element.tradePercentage : 0),
      ).then((value) => largestWinPercentage.value = value); // N
      await Future<double>.sync(
        () => tradeController.tradeList.minOf((element) =>
            element.tradePercentage < 0 ? element.tradePercentage : 0),
      ).then((value) => largestLossPercentage.value = value); // N

      // Average Trade
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradeController.tradeList.sumOfDouble((element) =>
                    element.tradeNominal > 0 ? element.tradeNominal : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinNominal.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradeController.tradeList.sumOfDouble((element) =>
                    element.tradeNominal < 0 ? element.tradeNominal : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossNominal.value = value);
      await Future<double>.sync(
        () => winTrade.value != 0
            ? tradeController.tradeList.sumOfDouble((element) =>
                    element.tradePercentage > 0 ? element.tradePercentage : 0) /
                winTrade.value
            : 0.0,
      ).then((value) => averageWinPercentage.value = value);
      await Future<double>.sync(
        () => loseTrade.value != 0
            ? tradeController.tradeList.sumOfDouble((element) =>
                    element.tradePercentage < 0 ? element.tradePercentage : 0) /
                loseTrade.value
            : 0.0,
      ).then((value) => averageLossPercentage.value = value);
      await Future<double>.sync(
        () => averageWinNominal.value / averageLossNominal.value,
      ).then((value) => averageRatio.value = value);

      // Trade Factor
      await Future<double>.sync(
        () => tradeController.tradeList.maxOf((element) => element.cap),
      ).then((value) => high.value = value);
      await Future<int>.sync(
        () => tradeController.tradeList
            .map((e) => e.cap)
            .toList()
            .indexOf(high.value),
      ).then((value) => highIndex.value = value);
      await Future<double>.sync(
        () => tradingInfoInput.initCap.value < low.value
            ? tradingInfoInput.initCap.value
            : tradeController.tradeList.minOf((element) => element.cap),
      ).then((value) => low.value = value);
      await Future<int>.sync(
        () => tradeController.tradeList
            .map((e) => e.cap)
            .toList()
            .indexOf(low.value),
      ).then((value) => lowIndex.value = value);

      lowAfterHigh.value = 0;
      highAfterlow.value = 0;

      Future.sync(() {
        runUpSequance.value = [];
        maxRunUpPercentage.value = 0.0;
        List tempList = [];
        double getLast = tradeController.tradeList.last.cap;
        for (var i = 0; i < tradeController.tradeList.length; i++) {
          if (i < 1) {
            tempList.add(tradeController.tradeList[i].cap);
          } else {
            if (getLast != tradeController.tradeList[i].cap) {
              if (tradeController.tradeList[i].cap <
                      tradeController.tradeList[i - 1].cap &&
                  tradeController.tradeList[i].cap <
                      tradeController.tradeList[i + 1].cap) {
                tempList.add(tradeController.tradeList[i].cap);
              }
            }
            if (tradeController.tradeList[i].cap >
                tradeController.tradeList[i - 1].cap) {
              tempList.add(tradeController.tradeList[i].cap);
            }
            if (getLast != tradeController.tradeList[i].cap) {
              if (tradeController.tradeList[i].cap >
                  tradeController.tradeList[i + 1].cap) {
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
        double getLast = tradeController.tradeList.last.cap;
        for (var i = 0; i < tradeController.tradeList.length; i++) {
          if (i < 1) {
            tempList.add(tradeController.tradeList[i].cap);
          } else {
            if (getLast != tradeController.tradeList[i].cap) {
              if (tradeController.tradeList[i].cap >
                      tradeController.tradeList[i - 1].cap &&
                  tradeController.tradeList[i].cap >
                      tradeController.tradeList[i + 1].cap) {
                tempList.add(tradeController.tradeList[i].cap);
              }
            }
            if (tradeController.tradeList[i].cap <
                tradeController.tradeList[i - 1].cap) {
              tempList.add(tradeController.tradeList[i].cap);
            }
            if (getLast != tradeController.tradeList[i].cap) {
              if (tradeController.tradeList[i].cap <
                  tradeController.tradeList[i + 1].cap) {
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
}

class TradingIndicator extends GetxController {
  var indicatorList = <IndicatorListModel>[].obs;

  var indicatorTitleController = TextEditingController();
  var indicatorTitleFocus = false.obs;
  var indicatorTitle = "".obs;
  var indicatorDescController = TextEditingController();
  var indicatorDescFocus = false.obs;
  var indicatorDesc = "".obs;

  Future<void> addIndicator() async {
    try {
      indicatorList.add(
        IndicatorListModel(
          indicatorName: indicatorTitleController.text,
          indicatorDesc: indicatorDescController.text,
        ),
      );
      indicatorTitleController.clear();
      indicatorDescController.clear();
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
}

class AdsController extends GetxController {
  final BannerAd listBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  late InterstitialAd interstitialAd;
  var adIsLoaded = false.obs;

  Future loadInterstitialAd() async {
    try {
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            printInfo(info: ad.adUnitId.toString());
            interstitialAd = ad;
            adIsLoaded.value = true;
            interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                interstitialAd.dispose();
                adIsLoaded.value = false;
                loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                interstitialAd.dispose();
                adIsLoaded.value = false;
              },
            );
          },
          onAdFailedToLoad: (error) {
            printError(info: error.toString());
          },
        ),
      );
    } catch (e) {
      printError(info: e.toString());
    }
  }

  // Future loadInterstitialAd() async {
  //   try {
  //     InterstitialAd.load(
  //       adUnitId: 'ca-app-pub-3940256099942544/8691691433',
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           // Keep a reference to the ad so you can show it later.
  //           interstitialAd = ad;
  //           adIsLoaded.value = true;
  //           printInfo(
  //               info: "ADS LOADED ADS LOADED ADS LOADED ADS LOADED ADS LOADED");
  //           interstitialAd.fullScreenContentCallback =
  //               FullScreenContentCallback(
  //             onAdDismissedFullScreenContent: (ad) {
  //               adIsLoaded.value = false;
  //               interstitialAd.dispose();
  //               Get.back();
  //               // loadInterstitialAd();d
  //             },
  //             onAdFailedToShowFullScreenContent: (ad, error) {
  //               adIsLoaded.value = false;
  //               interstitialAd.dispose();
  //               Get.back();
  //             },
  //           );
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           printError(info: 'InterstitialAd failed to load: $error');
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}

class TradeController extends GetxController {
  var test = "".obs;
  var strategyList = <StrategyListModel>[].obs;
  var strategyIndex = (-1).obs;

  var tradeList = <TradingListModel>[].obs;
  var tradeListScroll = ScrollController();

  var tabNavVisibility = true.obs;

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
    final TradingInfo tradingInfoInput = Get.put(TradingInfo());
    final TradingCalculation tradingCalculation = Get.put(TradingCalculation());
    final TradingIndicator tradingIndicator = Get.put(TradingIndicator());
    try {
      if (strategyIndex != -1) {
        strategyList[strategyIndex.value] = StrategyListModel(
          strategyTitle: tradingInfoInput.strategyTitle.value,
          duration: tradingInfoInput.duration.value,
          initCap: tradingInfoInput.initCap.value,
          gain: tradingCalculation.gain.value,
          winrate: tradingCalculation.winrate.value,
          tradingPair: tradingInfoInput.tradingPair.value,
          timeframe: tradingInfoInput.timeFrame.value,
          indicator: tradingIndicator.indicatorList.value,
          trade: tradeList.value,
        );
      } else {
        strategyList.add(
          StrategyListModel(
            strategyTitle: tradingInfoInput.strategyTitle.value,
            duration: tradingInfoInput.duration.value,
            initCap: tradingInfoInput.initCap.value,
            gain: tradingCalculation.gain.value,
            winrate: tradingCalculation.winrate.value,
            tradingPair: tradingInfoInput.tradingPair.value,
            timeframe: tradingInfoInput.timeFrame.value,
            indicator: tradingIndicator.indicatorList.value,
            trade: tradeList.value,
          ),
        );
      }

      // Future.delayed(Duration(seconds: 1), () {
      tradingInfoInput.strategyTitleController.clear();
      tradingInfoInput.strategyTitle.value = "";
      tradingInfoInput.tradingPairController.clear();
      tradingInfoInput.tradingPair.value = "";
      tradingInfoInput.timeFrameController.clear();
      tradingInfoInput.timeFrame.value = "";
      tradingInfoInput.durationController.clear();
      tradingInfoInput.duration.value = "";
      tradingInfoInput.initCapController.clear();
      tradingInfoInput.initCap.value = 0.0;
      tradingInfoInput.budgetController.clear();
      tradingInfoInput.budget.value = 0.0;
      tradingInfoInput.leverageController.clear();
      tradingInfoInput.leverage.value = 1;
      tradingInfoInput.feeController.clear();
      tradingInfoInput.fee.value = 0.0;
      tradingInfoInput.tradePercentageController.clear();
      tradingInfoInput.tradePercentage.value = 0.0;

      tradeList.value = [];
      tradingIndicator.indicatorList.value = [];
      // Fee
      tradingCalculation.totalFee.value = 0.0;
      tradingCalculation.averageFee.value = 0.0;

      // Total profit loss
      tradingCalculation.grossProfit.value = 0.0;
      tradingCalculation.grossLoss.value = 0.0;
      tradingCalculation.netoProfit.value = 0.0;
      tradingCalculation.profitFactor.value = 0.0;

      // Capital
      tradingCalculation.finalCap.value = 0.0;
      tradingCalculation.totalVolume.value = 0.0;
      tradingCalculation.gain.value = 0.0;

      // Trade & winrate
      tradingCalculation.winTrade.value = 0;
      tradingCalculation.loseTrade.value = 0;
      tradingCalculation.totalTrade.value = 0;
      tradingCalculation.winrate.value = 100.0;
      tradingCalculation.consecutiveWin.value = 0; // N
      tradingCalculation.consecutiveLoss.value = 0; // N

      // Largest trade
      tradingCalculation.largestWinNominal.value = 0.0;
      tradingCalculation.largestLossNominal.value = 0.0;
      tradingCalculation.largestWinPercentage.value = 0.0;
      tradingCalculation.largestLossPercentage.value = 0.0;

      // Average Trade
      tradingCalculation.averageWinNominal.value = 0.0;
      tradingCalculation.averageLossNominal.value = 0.0;
      tradingCalculation.averageWinPercentage.value = 0.0;
      tradingCalculation.averageLossPercentage.value = 0.0;
      tradingCalculation.averageRatio.value = 0.0; //N

      // Trade Factor
      tradingCalculation.high.value = 0.0;
      tradingCalculation.highIndex.value = 0; //N
      tradingCalculation.low.value = 0.0;
      tradingCalculation.lowIndex.value = 0; //N
      tradingCalculation.lowAfterHigh.value = 0; //N
      tradingCalculation.highAfterlow.value = 0; //N
      tradingCalculation.runUpSequance.value = []; // N
      // var runUpSequancePercentage = [].obs; // N
      tradingCalculation.maxRunUpPercentage.value = 0.0; // N
      tradingCalculation.drawDownSequance.value = []; //N
      // var drawDownSequancePercentage = [].obs; //N
      tradingCalculation.maxDrawdownPercentage.value = 0.0; //N
      // });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStrategy(int index) async {
    final TradingInfo tradingInfoInput = Get.put(TradingInfo());
    final TradingIndicator tradingIndicator = Get.put(TradingIndicator());
    try {
      strategyIndex.value = index;

      tradingInfoInput.strategyTitle.value = strategyList[index].strategyTitle;
      tradingInfoInput.strategyTitleController.text =
          strategyList[index].strategyTitle;

      tradingInfoInput.tradingPair.value = strategyList[index].tradingPair;
      tradingInfoInput.tradingPairController.text =
          strategyList[index].tradingPair;

      tradingInfoInput.timeFrame.value = strategyList[index].timeframe;
      tradingInfoInput.timeFrameController.text = strategyList[index].timeframe;

      tradingInfoInput.duration.value = strategyList[index].duration;
      tradingInfoInput.durationController.text = strategyList[index].duration;

      tradingInfoInput.initCap.value = strategyList[index].initCap;
      tradingInfoInput.initCapController.text =
          strategyList[index].initCap.toString();

      tradingInfoInput.budget.value =
          strategyList[index].trade.last.budgetPerccentage;
      tradingInfoInput.budgetController.text =
          strategyList[index].trade.last.budgetPerccentage.toString();

      tradingInfoInput.leverage.value =
          strategyList[index].trade.last.leverage.toInt();
      tradingInfoInput.leverageController.text =
          strategyList[index].trade.last.leverage.toString();

      tradingInfoInput.fee.value = strategyList[index].trade.last.feePercentage;
      tradingInfoInput.feeController.text =
          strategyList[index].trade.last.feePercentage.toString();

      tradingInfoInput.tradePercentage.value =
          strategyList[index].trade.last.tradePercentage;
      tradingInfoInput.tradePercentageController.text =
          strategyList[index].trade.last.tradePercentage.toString();

      tradeList.value = strategyList[index].trade;
      test.value = strategyList[index].trade.toString();
      tradingIndicator.indicatorList.value = strategyList[index].indicator;

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
}
