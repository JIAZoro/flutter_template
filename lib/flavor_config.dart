import 'package:flutter/material.dart';

enum Flavor {
  AppA,
  AppB,
}

class FlavorCongig {
  final Flavor flavor;
  final String appName;
  static late FlavorCongig instance;

  FlavorCongig._internal(this.flavor, this.appName);
  factory FlavorCongig({required Flavor flavor, required String appName}) {
    instance = FlavorCongig._internal(flavor, appName);
    return instance;
  }
}