// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatelessWidget {
  AdWithView ad;
  BannerAds({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
