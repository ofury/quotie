import 'package:json_annotation/json_annotation.dart';
part 'quote.g.dart';

@JsonSerializable()
class Quote {
  final List text;
  final String author;
  final List tags;

  Quote({this.text, this.author, this.tags});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

@JsonSerializable()
class QuoteList {
  List<Quote> quotes;

  QuoteList({this.quotes});

  factory QuoteList.fromJson(List<dynamic> json) {
    return QuoteList(
        quotes: json
            .map((e) => Quote.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
