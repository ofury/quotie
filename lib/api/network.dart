import 'package:flutter/services.dart';

class Network {
  final String url;

  Network(this.url);

  Future getData() async {
    print('Calling uri: $url');
    return await rootBundle.loadString(url);
  }
}
