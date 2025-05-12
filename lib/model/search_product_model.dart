class SearchProduct {
  final String name;
  final String url;
  final String refNo;

  SearchProduct({
    required this.name,
    required this.url,
    required this.refNo,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      name: json['Name'] ?? '',
      url: json['Url'] ?? '',
      refNo: json['RefNo'] ?? '',
    );
  }
}
