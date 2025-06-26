// import 'dart:convert';
//
// SellQuestion sellQuestionFromJson(String str) =>
//     SellQuestion.fromJson(json.decode(str));
//
// String sellQuestionToJson(SellQuestion data) => json.encode(data.toJson());
//
// class SellQuestion {
//   bool? status;
//   String? message;
//   List<Datum>? data;
//
//   SellQuestion({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory SellQuestion.fromJson(Map<String, dynamic> json) => SellQuestion(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   dynamic pageId;
//   String? pageTitle;
//   String? refNo;
//   dynamic rowUCode;
//   List<Question>? questions;
//
//   Datum({
//     this.pageId,
//     this.pageTitle,
//     this.refNo,
//     this.rowUCode,
//     this.questions,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         pageId: json["PageId"],
//         pageTitle: json["PageTitle"],
//         refNo: json["RefNo"],
//         rowUCode: json["RowUCode"],
//         questions: json["Questions"] == null
//             ? []
//             : List<Question>.from(
//                 json["Questions"]!.map((x) => Question.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "PageId": pageId,
//         "PageTitle": pageTitle,
//         "RefNo": refNo,
//         "RowUCode": rowUCode,
//         "Questions": questions == null
//             ? []
//             : List<dynamic>.from(questions!.map((x) => x.toJson())),
//       };
// }
//
// class Question {
//   String? questionId;
//   String? question;
//   String? questionDescription;
//   String? refNo;
//   dynamic rowUCode;
//   List<Option>? options;
//
//   Question({
//     this.questionId,
//     this.question,
//     this.questionDescription,
//     this.refNo,
//     this.rowUCode,
//     this.options,
//   });
//
//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//         questionId: json["QuestionId"],
//         question: json["Question"],
//         questionDescription: json["QuestionDescription"],
//         refNo: json["RefNo"],
//         rowUCode: ["RowUCode"],
//         options: json["Options"] == null
//             ? []
//             : List<Option>.from(
//                 json["Options"]!.map((x) => Option.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "QuestionId": questionId,
//         "Question": question,
//         "QuestionDescription": questionDescription,
//         "RefNo": refNo,
//         "RowUCode": [rowUCode],
//         "Options": options == null
//             ? []
//             : List<dynamic>.from(options!.map((x) => x.toJson())),
//       };
// }
//
// class Option {
//   dynamic pageId;
//   dynamic sellQuestionId;
//   String? questionSelection;
//   String? questionTitle;
//   String? priceType;
//   dynamic amount;
//   dynamic weightage;
//   String? questionId;
//   String? listOptionAns;
//   String? checkStatus;
//   String? refNo;
//   dynamic rowUCode;
//   bool? selected;
//
//
//   Option({
//     this.pageId,
//     this.sellQuestionId,
//     this.questionSelection,
//     this.questionTitle,
//     this.priceType,
//     this.amount,
//     this.weightage,
//     this.questionId,
//     this.listOptionAns,
//     this.checkStatus,
//     this.refNo,
//     this.rowUCode,
//
//   });
//
//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         pageId: json["PageId"],
//         sellQuestionId: json["SellQuestionId"],
//         questionSelection: json["QuestionSelection"],
//         questionTitle: json["QuestionTitle"],
//         priceType: json["PriceType"],
//         amount: json["Amount"],
//         weightage: (json["Weightage"]).toDouble(),
//         questionId: json["QuestionId"],
//         listOptionAns: json["ListOptionAns"],
//         checkStatus: json["CheckStatus"],
//         refNo: json["RefNo"],
//         rowUCode: json["RowUCode"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "PageId": pageId,
//         "SellQuestionId": sellQuestionId,
//         "QuestionSelection": questionSelection,
//         "QuestionTitle": questionTitle,
//         "PriceType": priceType,
//         "Amount": amount,
//         "weightage": weightage,
//         "QuestionId": questionId,
//         "ListOptionAns": listOptionAns,
//         "CheckStatus": checkStatus,
//         "RefNo": refNo,
//         "RowUCode": rowUCode,
//       };
// }


// To parse this JSON data, do
//
//     final sellQuestionModel = sellQuestionModelFromJson(jsonString);

import 'dart:convert';

SellQuestionModel sellQuestionModelFromJson(String str) => SellQuestionModel.fromJson(json.decode(str));

String sellQuestionModelToJson(SellQuestionModel data) => json.encode(data.toJson());

class SellQuestionModel {
  bool? status;
  String? message;
  int? totalPageNumber;
  List<Datum>? data;

  SellQuestionModel({
    this.status,
    this.message,
    this.totalPageNumber,
    this.data,
  });

  SellQuestionModel copyWith({
    bool? status,
    String? message,
    int? totalPageNumber,
    List<Datum>? data,
  }) =>
      SellQuestionModel(
        status: status ?? this.status,
        message: message ?? this.message,
        totalPageNumber: totalPageNumber ?? this.totalPageNumber,
        data: data ?? this.data,
      );

  factory SellQuestionModel.fromJson(Map<String, dynamic> json) => SellQuestionModel(
    status: json["status"],
    message: json["message"],
    totalPageNumber: json["TotalPageNumber"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "TotalPageNumber": totalPageNumber,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? pageId;
  String? pageTitle;
  String? pageDescription;
  String? refNo;
  RowUCode? rowUCode;
  List<Question>? questions;

  Datum({
    this.pageId,
    this.pageTitle,
    this.pageDescription,
    this.refNo,
    this.rowUCode,
    this.questions,
  });

  Datum copyWith({
    int? pageId,
    String? pageTitle,
    String? pageDescription,
    String? refNo,
    RowUCode? rowUCode,
    List<Question>? questions,
  }) =>
      Datum(
        pageId: pageId ?? this.pageId,
        pageTitle: pageTitle ?? this.pageTitle,
        pageDescription: pageDescription ?? this.pageDescription,
        refNo: refNo ?? this.refNo,
        rowUCode: rowUCode ?? this.rowUCode,
        questions: questions ?? this.questions,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    pageId: json["PageId"],
    pageTitle: json["PageTitle"],
    pageDescription: json["PageDescription"],
    refNo: json["RefNo"],
    rowUCode: rowUCodeValues.map[json["RowUCode"]]!,
    questions: json["Questions"] == null ? [] : List<Question>.from(json["Questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PageId": pageId,
    "PageTitle": pageTitle,
    "PageDescription": pageDescription,
    "RefNo": refNo,
    "RowUCode": rowUCodeValues.reverse[rowUCode],
    "Questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  String? questionId;
  String? question;
  String? questionDescription;
  String? refNo;
  RowUCode? rowUCode;
  List<Option>? options;

  Question({
    this.questionId,
    this.question,
    this.questionDescription,
    this.refNo,
    this.rowUCode,
    this.options,
  });

  Question copyWith({
    String? questionId,
    String? question,
    String? questionDescription,
    String? refNo,
    RowUCode? rowUCode,
    List<Option>? options,
  }) =>
      Question(
        questionId: questionId ?? this.questionId,
        question: question ?? this.question,
        questionDescription: questionDescription ?? this.questionDescription,
        refNo: refNo ?? this.refNo,
        rowUCode: rowUCode ?? this.rowUCode,
        options: options ?? this.options,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["QuestionId"],
    question: json["Question"],
    questionDescription: json["QuestionDescription"],
    refNo: json["RefNo"],
    rowUCode: rowUCodeValues.map[json["RowUCode"]]!,
    options: json["Options"] == null ? [] : List<Option>.from(json["Options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "QuestionId": questionId,
    "Question": question,
    "QuestionDescription": questionDescription,
    "RefNo": refNo,
    "RowUCode": rowUCodeValues.reverse[rowUCode],
    "Options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  int? pageId;
  dynamic sellQuestionId;
  dynamic catId;
  dynamic categoryName;
  dynamic answerId;
  String? answerRef;
  QuestionSelection? questionSelection;
  PriceType? priceType;
  dynamic amount;
  double? weightage;
  String? questionId;
  String? listOptionAns;
  String? refNo;
  RowUCode? rowUCode;

  Option({
    this.pageId,
    this.sellQuestionId,
    this.catId,
    this.categoryName,
    this.answerId,
    this.answerRef,
    this.questionSelection,
    this.priceType,
    this.amount,
    this.weightage,
    this.questionId,
    this.listOptionAns,
    this.refNo,
    this.rowUCode,
  });

  Option copyWith({
    int? pageId,
    dynamic sellQuestionId,
    dynamic catId,
    dynamic categoryName,
    dynamic answerId,
    String? answerRef,
    QuestionSelection? questionSelection,
    PriceType? priceType,
    dynamic amount,
    double? weightage,
    String? questionId,
    String? listOptionAns,
    String? refNo,
    RowUCode? rowUCode,
  }) =>
      Option(
        pageId: pageId ?? this.pageId,
        sellQuestionId: sellQuestionId ?? this.sellQuestionId,
        catId: catId ?? this.catId,
        categoryName: categoryName ?? this.categoryName,
        answerId: answerId ?? this.answerId,
        answerRef: answerRef ?? this.answerRef,
        questionSelection: questionSelection ?? this.questionSelection,
        priceType: priceType ?? this.priceType,
        amount: amount ?? this.amount,
        weightage: weightage ?? this.weightage,
        questionId: questionId ?? this.questionId,
        listOptionAns: listOptionAns ?? this.listOptionAns,
        refNo: refNo ?? this.refNo,
        rowUCode: rowUCode ?? this.rowUCode,
      );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    pageId: json["PageId"],
    sellQuestionId: json["SellQuestionId"],
    catId: json["CatId"],
    categoryName: json["CategoryName"],
    answerId: json["AnswerId"],
    answerRef: json["AnswerRef"],
    questionSelection: questionSelectionValues.map[json["QuestionSelection"]]!,
    priceType: priceTypeValues.map[json["PriceType"]]!,
    amount: json["Amount"],
    weightage: json["Weightage"]?.toDouble(),
    questionId: json["QuestionId"],
    listOptionAns: json["ListOptionAns"],
    refNo: json["RefNo"],
    rowUCode: rowUCodeValues.map[json["RowUCode"]]!,
  );

  Map<String, dynamic> toJson() => {
    "PageId": pageId,
    "SellQuestionId": sellQuestionId,
    "CatId": catId,
    "CategoryName": categoryName,
    "AnswerId": answerId,
    "AnswerRef": answerRef,
    "QuestionSelection": questionSelectionValues.reverse[questionSelection],
    "PriceType": priceTypeValues.reverse[priceType],
    "Amount": amount,
    "Weightage": weightage,
    "QuestionId": questionId,
    "ListOptionAns": listOptionAns,
    "RefNo": refNo,
    "RowUCode": rowUCodeValues.reverse[rowUCode],
  };
}

enum PriceType {
  PERCENTAGE
}

final priceTypeValues = EnumValues({
  "Percentage": PriceType.PERCENTAGE
});

enum QuestionSelection {
  MULTIPLE_SELECTION_BOX,
  RADIO_BUTTON_YES_NO,
  SIGLE_SELECTION_BOX
}

final questionSelectionValues = EnumValues({
  "Multiple Selection Box": QuestionSelection.MULTIPLE_SELECTION_BOX,
  "Radio Button(Yes/No)": QuestionSelection.RADIO_BUTTON_YES_NO,
  "Sigle Selection Box": QuestionSelection.SIGLE_SELECTION_BOX
});

enum RowUCode {
  A576_FB00_48284_A5_E_A52_E_9657_D5396_CE41,
  AE9_B6019_5_B18_4_C39_86_FA_74_E6818_D0_CF41,
  BC0_EFF54_73_CC_49_D3_A913_FB98_D43_C01741,
  C40_D46_E4_69_B8_426_F_BB7_C_1654078_AB4571,
  C726_FC46_09_C4_42_ED_BE54_CFFEC750_CB351,
  THE_084_B1208_16_E5_4_E3_F_8_D3_F_A419246115_BD1,
  THE_833_D45_AB_0_F68_47_B0_BB69_E49608_EBD56_D1
}

final rowUCodeValues = EnumValues({
  "a576fb00-4828-4a5e-a52e-9657d5396ce41": RowUCode.A576_FB00_48284_A5_E_A52_E_9657_D5396_CE41,
  "ae9b6019-5b18-4c39-86fa-74e6818d0cf41": RowUCode.AE9_B6019_5_B18_4_C39_86_FA_74_E6818_D0_CF41,
  "bc0eff54-73cc-49d3-a913-fb98d43c01741": RowUCode.BC0_EFF54_73_CC_49_D3_A913_FB98_D43_C01741,
  "c40d46e4-69b8-426f-bb7c-1654078ab4571": RowUCode.C40_D46_E4_69_B8_426_F_BB7_C_1654078_AB4571,
  "c726fc46-09c4-42ed-be54-cffec750cb351": RowUCode.C726_FC46_09_C4_42_ED_BE54_CFFEC750_CB351,
  "084b1208-16e5-4e3f-8d3f-a419246115bd1": RowUCode.THE_084_B1208_16_E5_4_E3_F_8_D3_F_A419246115_BD1,
  "833d45ab-0f68-47b0-bb69-e49608ebd56d1": RowUCode.THE_833_D45_AB_0_F68_47_B0_BB69_E49608_EBD56_D1
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

