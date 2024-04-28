import 'package:bb_example_app/product/utility/app_constants.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class EthClient {
  EthClient._init();

  static final EthClient _instance = EthClient._init();

  ///Returns instace for EthClient
  static EthClient get instance => _instance;

  final httpClient = Client();
  Web3Client get ethClient => Web3Client(provider, httpClient);

  Future<void> pay(
      EthPrivateKey privateKey, String targetAdress, double amount) async {
    try {
      await ethClient.sendTransaction(
        privateKey,
        Transaction(
          to: EthereumAddress.fromHex(targetAdress),
          from: privateKey.address,
          value: EtherAmount.fromInt(
            EtherUnit.gwei,
            convertDecimalToInteger(1),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  int convertDecimalToInteger(double decimal) {
    const factor = 1000000000;
    return (decimal * factor).round();
  }
}
