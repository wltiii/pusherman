/*
TODO Note: remember to properly cancel the subscription when it's no longer needed. See connectivity package docs for more info.
TODO See https://pub.dev/packages/data_connection_checker
TODO See https://stackoverflow.com/questions/1560788/how-to-check-internet-access-on-android-inetaddress-never-times-out/27312494#27312494
 */
//TODO temporarily use fork until owner migrates to null safety
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:data_connection_checker/lib/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}