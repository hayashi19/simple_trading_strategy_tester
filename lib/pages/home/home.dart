// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_trading_strategy_tester/pages/home/home_desktop.dart';
import 'package:simple_trading_strategy_tester/pages/home/home_mobile.dart';
import 'package:simple_trading_strategy_tester/pages/home/home_notSupportedDevice.dart';
import 'package:simple_trading_strategy_tester/pages/home/home_web.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isMobile) {
      return const HomePageMobile();
    } else if (GetPlatform.isWeb) {
      return const HomePageWeb();
    } else if (GetPlatform.isDesktop) {
      return const HomePageDesktop();
    } else {
      return const NotSupportedPage();
    }
  }
}

// class HomePage_Mobile extends StatelessWidget {
//   const HomePage_Mobile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final TradeController controller = Get.find();
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: TabBarView(
//                 children: <Widget>[
//                   Column(
//                     children: const <Widget>[
//                       Expanded(child: TradePage()),
//                       Divider(
//                         height: 24,
//                         color: Colors.grey,
//                       ),
//                       Expanded(child: HistoryPage()),
//                     ],
//                   ),
//                   const PerformancePage(),
//                   const IndicatorPage(),
//                 ],
//               ),
//             ),
//           ),
//           ADS(ad: controller.listBanner),
//           const TabBar(
//             tabs: [
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Icon(Icons.candlestick_chart_rounded),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Icon(Icons.show_chart_rounded),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Icon(Icons.bar_chart_rounded),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomePage_Desktop extends StatelessWidget {
//   const HomePage_Desktop({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         children: <Widget>[
//           const Expanded(
//             flex: 1,
//             child: PerformancePage(),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   flex: 3,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const <Widget>[
//                       Expanded(child: HistoryPage()),
//                       SizedBox(width: 10),
//                       Expanded(child: TradePage())
//                     ],
//                   ),
//                 ),
//                 const Divider(
//                   height: 24,
//                   thickness: 2,
//                   color: Colors.grey,
//                 ),
//                 const Expanded(
//                   flex: 2,
//                   child: IndicatorPage(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
