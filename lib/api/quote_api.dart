import 'network.dart';

const String QuoteAPILocal = 'assets/quotes.json';

class QuoteAPI {
  Future<dynamic> getAllQuotes() async {
    Network network = Network('$QuoteAPILocal');
    var quotesData = await network.getData();
    return quotesData;
  }
}
