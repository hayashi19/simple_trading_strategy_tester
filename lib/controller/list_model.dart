import 'dart:convert';

class StrategyListModel {
  String strategyTitle, duration, timeframe, tradingPair;
  double initCap, gain, winrate;
  List<IndicatorListModel> indicator;
  List<TradingListModel> trade;

  StrategyListModel({
    required this.strategyTitle,
    required this.duration,
    required this.initCap,
    required this.gain,
    required this.winrate,
    required this.tradingPair,
    required this.timeframe,
    required this.indicator,
    required this.trade,
  });

  factory StrategyListModel.fromJson(Map json) => StrategyListModel(
        strategyTitle: json['strategyTitle'],
        duration: json['duration'],
        initCap: json['initCap'],
        gain: json['gain'],
        winrate: json['winrate'],
        timeframe: json['timeframe'],
        tradingPair: json['tradingPair'],
        indicator: List<IndicatorListModel>.from(
          jsonDecode(json['indicator'].toString()).map(
            (data) => IndicatorListModel.fromJson(data),
          ),
        ),
        trade: List<TradingListModel>.from(
          jsonDecode(json['trade'].toString()).map(
            (data) => TradingListModel.fromJson(data),
          ),
        ),
      );

  Map toJson() => {
        'strategyTitle': strategyTitle,
        'duration': duration,
        'initCap': initCap,
        'gain': gain,
        'winrate': winrate,
        'timeframe': timeframe,
        'tradingPair': tradingPair,
        'indicator': jsonEncode(indicator.toList()),
        'trade': jsonEncode(trade.toList()),
      };
}

class IndicatorListModel {
  String indicatorName, indicatorDesc;

  IndicatorListModel({
    required this.indicatorName,
    required this.indicatorDesc,
  });

  factory IndicatorListModel.fromJson(Map<String, dynamic> json) =>
      IndicatorListModel(
        indicatorName: json['indicatorName'],
        indicatorDesc: json['indicatorDesc'],
      );

  Map<String, dynamic> toJson() => {
        'indicatorName': indicatorName,
        'indicatorDesc': indicatorDesc,
      };
}

class TradingListModel {
  double tradePercentage,
      tradeNominal,
      feePercentage,
      feeNominal,
      leverage,
      changes,
      cap,
      budget,
      budgetPerccentage;

  TradingListModel({
    required this.tradePercentage,
    required this.tradeNominal,
    required this.feePercentage,
    required this.feeNominal,
    required this.leverage,
    required this.changes,
    required this.cap,
    required this.budget,
    required this.budgetPerccentage,
  });

  factory TradingListModel.fromJson(Map json) => TradingListModel(
        tradePercentage: json['tradePercentage'],
        tradeNominal: json['tradeNominal'],
        feePercentage: json['feePercentage'],
        feeNominal: json['feeNominal'],
        leverage: json['leverage'],
        changes: json['changes'],
        cap: json['cap'],
        budget: json['budget'],
        budgetPerccentage: json['budgetPerccentage'],
      );

  Map<String, dynamic> toJson() => {
        'tradePercentage': tradePercentage,
        'tradeNominal': tradeNominal,
        'feePercentage': feePercentage,
        'feeNominal': feeNominal,
        'leverage': leverage,
        'changes': changes,
        'cap': cap,
        'budget': budget,
        'budgetPerccentage': budgetPerccentage,
      };
}

class Possibility {
  List maxSequance;
  double maxSequancePercentage;

  Possibility({
    required this.maxSequance,
    required this.maxSequancePercentage,
  });

  factory Possibility.fromJson(Map json) => Possibility(
        maxSequance: json['maxSequance'],
        maxSequancePercentage: json['maxSequancePercentage'],
      );

  Map<String, dynamic> toJson() => {
        'maxSequance': maxSequance,
        'maxSequancePercentage': maxSequancePercentage,
      };
}
