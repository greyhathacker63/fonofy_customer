// To parse this JSON data, do
//
//     final deliveryCodeModel = deliveryCodeModelFromJson(jsonString);

import 'dart:convert';

DeliveryPinCodeModel deliveryCodeModelFromJson(String str) => DeliveryPinCodeModel.fromJson(json.decode(str));

String deliveryCodeModelToJson(DeliveryPinCodeModel data) => json.encode(data.toJson());

class DeliveryPinCodeModel {
  List<DeliveryCode>? deliveryCodes;

  DeliveryPinCodeModel({
    this.deliveryCodes,
  });

  factory DeliveryPinCodeModel.fromJson(Map<String, dynamic> json) => DeliveryPinCodeModel(
    deliveryCodes: json["delivery_codes"] == null ? [] : List<DeliveryCode>.from(json["delivery_codes"]!.map((x) => DeliveryCode.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "delivery_codes": deliveryCodes == null ? [] : List<dynamic>.from(deliveryCodes!.map((x) => x.toJson())),
  };
}
class DeliveryCode {
  PostalCode? postalCode;

  DeliveryCode({
    this.postalCode,
  });

  factory DeliveryCode.fromJson(Map<String, dynamic> json) => DeliveryCode(
    postalCode: json["postal_code"] == null ? null : PostalCode.fromJson(json["postal_code"]),
  );

  Map<String, dynamic> toJson() => {
    "postal_code": postalCode?.toJson(),
  };
}

class PostalCode {
  dynamic maxWeight;
  String? city;
  String? cod;
  String? inc;
  String? district;
  dynamic pin;
  dynamic maxAmount;
  String? prePaid;
  String? cash;
  String? stateCode;
  String? remarks;
  String? pickup;
  String? repl;
  String? covidZone;
  String? countryCode;
  String? isOda;
  bool? protectBlacklist;
  String? sortCode;
  bool? sunTat;
  List<Center>? center;

  PostalCode({
    this.maxWeight,
    this.city,
    this.cod,
    this.inc,
    this.district,
    this.pin,
    this.maxAmount,
    this.prePaid,
    this.cash,
    this.stateCode,
    this.remarks,
    this.pickup,
    this.repl,
    this.covidZone,
    this.countryCode,
    this.isOda,
    this.protectBlacklist,
    this.sortCode,
    this.sunTat,
    this.center,
  });

  factory PostalCode.fromJson(Map<String, dynamic> json) => PostalCode(
    maxWeight: json["max_weight"],
    city: json["city"],
    cod: json["cod"],
    inc: json["inc"],
    district: json["district"],
    pin: json["pin"],
    maxAmount: json["max_amount"],
    prePaid: json["pre_paid"],
    cash: json["cash"],
    stateCode: json["state_code"],
    remarks: json["remarks"],
    pickup: json["pickup"],
    repl: json["repl"],
    covidZone: json["covid_zone"],
    countryCode: json["country_code"],
    isOda: json["is_oda"],
    protectBlacklist: json["protect_blacklist"],
    sortCode: json["sort_code"],
    sunTat: json["sun_tat"],
    center: json["center"] == null ? [] : List<Center>.from(json["center"]!.map((x) => Center.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "max_weight": maxWeight,
    "city": city,
    "cod": cod,
    "inc": inc,
    "district": district,
    "pin": pin,
    "max_amount": maxAmount,
    "pre_paid": prePaid,
    "cash": cash,
    "state_code": stateCode,
    "remarks": remarks,
    "pickup": pickup,
    "repl": repl,
    "covid_zone": covidZone,
    "country_code": countryCode,
    "is_oda": isOda,
    "protect_blacklist": protectBlacklist,
    "sort_code": sortCode,
    "sun_tat": sunTat,
    "center": center == null ? [] : List<dynamic>.from(center!.map((x) => x.toJson())),
  };
}

class Center {
  String? code;
  DateTime? e;
  String? cn;
  DateTime? s;
  DateTime? ud;
  String? sortCode;
  String? u;

  Center({
    this.code,
    this.e,
    this.cn,
    this.s,
    this.ud,
    this.sortCode,
    this.u,
  });
  factory Center.fromJson(Map<String, dynamic> json) => Center(
    code: json["code"],
    e: json["e"] == null ? null : DateTime.parse(json["e"]),
    cn: json["cn"],
    s: json["s"] == null ? null : DateTime.parse(json["s"]),
    ud: json["ud"] == null ? null : DateTime.parse(json["ud"]),
    sortCode: json["sort_code"],
    u: json["u"],
  );
  Map<String, dynamic> toJson() => {
    "code": code,
    "e": e?.toIso8601String(),
    "cn": cn,
    "s": s?.toIso8601String(),
    "ud": ud?.toIso8601String(),
    "sort_code": sortCode,
    "u": u,
  };
}
