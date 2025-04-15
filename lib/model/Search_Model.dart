class SearchModel {
  final String name;
  final String image;
  final double amount;
  final double oldPrice;
  final double rating;
  final int reviews;
  final List<String> availableColors;
  final String url;

  SearchModel({
    required this.name,
    required this.image,
    required this.amount,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.availableColors,
    required this.url,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      name: json['Name'] ?? '',
      image: json['Image'] != null
          ? 'https://api.fonofy.in${json['Image']}'
          : '',
      amount: (json['Amount'] is int || json['Amount'] is double)
          ? json['Amount'].toDouble()
          : double.tryParse(json['Amount'].toString()) ?? 0.0,
      oldPrice: (json['OldPrice'] is int || json['OldPrice'] is double)
          ? json['OldPrice'].toDouble()
          : double.tryParse(json['OldPrice'].toString()) ?? 0.0,
      rating: (json['Rating'] is int || json['Rating'] is double)
          ? json['Rating'].toDouble()
          : double.tryParse(json['Rating'].toString()) ?? 0.0,
      reviews: json['Reviews'] ?? 0,
      availableColors: List<String>.from(json['AvailableColors'] ?? []),
      url: json['Url'] ?? '',
    );
  }
}
