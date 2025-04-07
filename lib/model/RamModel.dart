// To parse this JSON data, do
//
//     final ramModel = ramModelFromJson(jsonString);
// List<RamModel> ramModelFromJson(String str) => List<RamModel>.from(json.decode(str).map((x) => RamModel.fromJson(x)));

// String ramModelToJson(List<RamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class RamModel {
    int? id;
    String? ramName;

    RamModel({
        this.id,
        this.ramName,
    });

    factory RamModel.fromJson(Map<String, dynamic> json) => RamModel(
        id: json["id"],
        ramName: json["RamName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "RamName": ramName,
    };
}
