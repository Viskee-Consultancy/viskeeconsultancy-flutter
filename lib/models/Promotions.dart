import 'Promotion.dart';

class Promotions {
  List<Promotion> promotions =List.empty();

  Promotions.fromJson(Map<String, dynamic> json) {
    var promotionJsonList = json['promotions'] as List;
    promotions = promotionJsonList.map((i) => Promotion.fromJson(i)).toList();
  }
}