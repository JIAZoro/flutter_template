
enum Flavor {
  DevEnv,
  TestEnv,
  ProdEnv,
}

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  static late FlavorConfig instance;

  FlavorConfig._internal(this.flavor, this.appName);
  factory FlavorConfig({required Flavor flavor, required String appName}) {
    instance = FlavorConfig._internal(flavor, appName);
    return instance;
  }
}