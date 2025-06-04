class SearchProductModel {
  final String name;
  final String url;
  final String refNo;

  SearchProductModel({
    required this.name,
    required this.url,
    required this.refNo,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      name: json['Name'] ?? '',
      url: json['Url'] ?? '',
      refNo: json['RefNo'] ?? '',
    );
  }
}
