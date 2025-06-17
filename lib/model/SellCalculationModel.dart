class PriceEvaluation {
  final dynamic basePrice;
  final dynamic weightedScore;
  final dynamic finalPrice;

  PriceEvaluation({
    required this.basePrice,
    required this.weightedScore,
    required this.finalPrice,
  });

  factory PriceEvaluation.fromJson(Map<String, dynamic> json) {
    return PriceEvaluation(
      basePrice: json['BasePrice'] ,
      weightedScore: json['WeightedScore'] ,
      finalPrice: json['FinalPrice'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BasePrice': basePrice,
      'WeightedScore': weightedScore,
      'FinalPrice': finalPrice,
    };
  }
}
