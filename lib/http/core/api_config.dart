class APIConfig {
  final String apiHost;
  final String debugUserName;
  final String debugPassword;

  APIConfig({required this.apiHost, required this.debugUserName, required this.debugPassword});
  @override
  String toString() {
    return '$apiHost, debugUserName: $debugUserName, debugPassword: $debugPassword';
  }
}

abstract class Env {
  String get title;
  APIConfig get apiConfig;

  @override
  String toString() {
    return 'title: $title \n, apiConfig: ${apiConfig.toString()}\n';
  }
}

class DevEnv extends Env {
  @override
  String get title => 'DevEnv';

  @override
  APIConfig get apiConfig => APIConfig(apiHost: 'http://www.env.com', debugUserName: '', debugPassword: '');
}

class TestEnv extends Env {
  @override
  String get title => 'TestEnv';

  @override
  APIConfig get apiConfig => APIConfig(apiHost: 'http://www.TestEnv.com', debugUserName: '', debugPassword: '');
}

class ProductEnv extends Env {
  @override
  String get title => 'ProductEnv';

  @override
  APIConfig get apiConfig => APIConfig(apiHost: 'http://www.ProductEnv.com', debugUserName: '', debugPassword: '');
}
