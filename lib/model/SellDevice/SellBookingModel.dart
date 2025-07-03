class Sellbookingmodel {
  final int? modelId;
  final int? romId;
  final int? ramId;
  final int? colorId;
  final String? customerId;
  final String? orderId;
  final String? shippingId;
  final String? shippingName;
  final String? shippingMobileNo;
  final String? shippingEmailId;
  final String? shippingAddress;
  final String? shippingLandmark;
  final dynamic shippingCity;
  final dynamic shippingState;
  final String? shippingPincode;
  final String? workType;
  final String? pickupslotDate;
  final String? pickupslotTime;
  final int? accountId;
  final String? accountType;
  final String? remark;
  final double? pickupCharge;
  final double? processingFee;
  final double? totalAmount;
  final double? totalPrice;
  final double? totalDiscount;
  final double? totalMRP;
  final List<SellQuestionList>? sellquestionlists;

  Sellbookingmodel({
    this.modelId,
    this.romId,
    this.ramId,
    this.colorId,
    this.customerId,
    this.orderId,
    this.shippingId,
    this.shippingName,
    this.shippingMobileNo,
    this.shippingEmailId,
    this.shippingAddress,
    this.shippingLandmark,
    this.shippingCity,
    this.shippingState,
    this.shippingPincode,
    this.workType,
    this.pickupslotDate,
    this.pickupslotTime,
    this.accountId,
    this.accountType,
    this.remark,
    this.pickupCharge,
    this.processingFee,
    this.totalAmount,
    this.totalPrice,
    this.totalDiscount,
    this.totalMRP,
    this.sellquestionlists,
  });

  factory Sellbookingmodel.fromJson(Map<String, dynamic> json) {
    return Sellbookingmodel(
      modelId: json['ModelId'] as int?,
      romId: json['ROMId'] as int?,
      ramId: json['RAMId'] as int?,
      colorId: json['ColorId'] as int?,
      customerId: json['CustomerId'] as String?,
      orderId: json['OrderId'] as String?,
      shippingId: json['ShippingId'] as String?,
      shippingName: json['ShippingName'] as String?,
      shippingMobileNo: json['ShippingMobileNo'] as String?,
      shippingEmailId: json['ShippingEmailId'] as String?,
      shippingAddress: json['ShippingAddress'] as String?,
      shippingLandmark: json['ShippingLandmark'] as String?,
      shippingCity: json['ShippingCity'] as int?,
      shippingState: json['ShippingState'] as int?,
      shippingPincode: json['ShippingPincode'] as String?,
      workType: json['WorkType'] as String?,
      pickupslotDate: json['PickupslotDate'] as String?,
      pickupslotTime: json['PickupslotTime'] as String?,
      accountId: json['AccountId'] as int?,
      accountType: json['AccountType'] as String?,
      remark: json['Remark'] as String?,
      pickupCharge: (json['PickupCharge'] as num?)?.toDouble(),
      processingFee: (json['ProcessingFee'] as num?)?.toDouble(),
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      totalDiscount: (json['TotalDiscount'] as num?)?.toDouble(),
      totalMRP: (json['TotalMRP'] as num?)?.toDouble(),
      sellquestionlists: (json['sellquestionlists'] as List<dynamic>?)?.map((item) => SellQuestionList.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ModelId': modelId,
      'ROMId': romId,
      'RAMId': ramId,
      'ColorId': colorId,
      'CustomerId': customerId,
      'OrderId': orderId,
      'ShippingId': shippingId,
      'ShippingName': shippingName,
      'ShippingMobileNo': shippingMobileNo,
      'ShippingEmailId': shippingEmailId,
      'ShippingAddress': shippingAddress,
      'ShippingLandmark': shippingLandmark,
      'ShippingCity': shippingCity,
      'ShippingState': shippingState,
      'ShippingPincode': shippingPincode,
      'WorkType': workType,
      'PickupslotDate': pickupslotDate,
      'PickupslotTime': pickupslotTime,
      'AccountId': accountId,
      'AccountType': accountType,
      'Remark': remark,
      'PickupCharge': pickupCharge,
      'ProcessingFee': processingFee,
      'TotalAmount': totalAmount,
      'TotalPrice': totalPrice,
      'TotalDiscount': totalDiscount,
      'TotalMRP': totalMRP,
      'sellquestionlists': sellquestionlists?.map((e) => e.toJson()).toList(),
    };
  }
}

class SellQuestionList {
  final String? questionRefno;
  final String? question;
  final int? questionId;
  final int? answerId;
  final String? answer;
  final double? weightage;

  SellQuestionList({
    this.questionRefno,
    this.question,
    this.questionId,
    this.answerId,
    this.answer,
    this.weightage,
  });

  factory SellQuestionList.fromJson(Map<String, dynamic> json) {
    return SellQuestionList(
      questionRefno: json['QuestionRefno'] as String?,
      question: json['Question'] as String?,
      questionId: json['QuestionId'] as int?,
      answerId: json['AnswerId'] as int?,
      answer: json['Answer'] as String?,
      weightage: (json['weightage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QuestionRefno': questionRefno,
      'Question': question,
      'QuestionId': questionId,
      'AnswerId': answerId,
      'Answer': answer,
      'weightage': weightage,
    };
  }
}