import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworInfoImpl(this.connectionChecker);
  @override

  Future<bool> get isConnected => connectionChecker.hasConnection;
}
