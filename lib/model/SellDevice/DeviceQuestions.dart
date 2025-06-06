import 'dart:convert';

// Parent model for the entire API response
class DeviceQuestions {
  final List<PageDetails> table;
  final List<PageQuestionMapping> table1;
  final List<QuestionDetails> table2;

  DeviceQuestions({
    required this.table,
    required this.table1,
    required this.table2,
  });

  factory DeviceQuestions.fromJson(Map<String, dynamic> json) {
    return DeviceQuestions(
      table: (json['Table'] as List)
          .map((item) => PageDetails.fromJson(item))
          .toList(),
      table1: (json['Table1'] as List)
          .map((item) => PageQuestionMapping.fromJson(item))
          .toList(),
      table2: (json['Table2'] as List)
          .map((item) => QuestionDetails.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Table': table.map((item) => item.toJson()).toList(),
      'Table1': table1.map((item) => item.toJson()).toList(),
      'Table2': table2.map((item) => item.toJson()).toList(),
    };
  }
}

// Model for "Table" - Page details
class PageDetails {
  final int pageId;
  final String pageTitle;
  final String pageDescription;
  final String refNo;
  final String rowUCode;

  PageDetails({
    required this.pageId,
    required this.pageTitle,
    required this.pageDescription,
    required this.refNo,
    required this.rowUCode,
  });

  factory PageDetails.fromJson(Map<String, dynamic> json) {
    return PageDetails(
      pageId: json['PageId'] as int,
      pageTitle: json['PageTitle'] as String,
      pageDescription: json['PageDescription'] as String,
      refNo: json['RefNo'] as String,
      rowUCode: json['RowUCode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PageId': pageId,
      'PageTitle': pageTitle,
      'PageDescription': pageDescription,
      'RefNo': refNo,
      'RowUCode': rowUCode,
    };
  }
}

// Model for "Table1" - Page and question mapping
class PageQuestionMapping {
  final int pageId;
  final String pageName;
  final String questionId;
  final int brandId;
  final String rowUCode;
  final String refNo;

  PageQuestionMapping({
    required this.pageId,
    required this.pageName,
    required this.questionId,
    required this.brandId,
    required this.rowUCode,
    required this.refNo,
  });

  factory PageQuestionMapping.fromJson(Map<String, dynamic> json) {
    return PageQuestionMapping(
      pageId: json['PageId'] as int,
      pageName: json['PageName'] as String,
      questionId: json['QuestionId'] as String,
      brandId: json['BrandId'] as int,
      rowUCode: json['RowUCode'] as String,
      refNo: json['RefNo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PageId': pageId,
      'PageName': pageName,
      'QuestionId': questionId,
      'BrandId': brandId,
      'RowUCode': rowUCode,
      'RefNo': refNo,
    };
  }
}

// Model for "Table2" - Question details with options
class QuestionDetails {
  final int pageId;
  final int id;
  final String question;
  final String questionDescription;
  final String questionSelection;
  final String questionTitle;
  final String priceType;
  final double amount;
  final double weightage;
  final String questionId;
  final String listOptionAns;
  final String checkStatus;
  final String refNo;
  final String rowUCode;

  QuestionDetails({
    required this.pageId,
    required this.id,
    required this.question,
    required this.questionDescription,
    required this.questionSelection,
    required this.questionTitle,
    required this.priceType,
    required this.amount,
    required this.weightage,
    required this.questionId,
    required this.listOptionAns,
    required this.checkStatus,
    required this.refNo,
    required this.rowUCode,
  });

  factory QuestionDetails.fromJson(Map<String, dynamic> json) {
    return QuestionDetails(
      pageId: json['PageId'] as int,
      id: json['Id'] as int,
      question: json['Question'] as String,
      questionDescription: json['QuestionDescription'] as String,
      questionSelection: json['QuestionSelection'] as String,
      questionTitle: json['QuestionTitle'] as String,
      priceType: json['PriceType'] as String,
      amount: (json['Amount'] as num).toDouble(),
      weightage: (json['weightage'] as num).toDouble(),
      questionId: json['QuestionId'] as String,
      listOptionAns: json['ListOptionAns'] as String,
      checkStatus: json['CheckStatus'] as String,
      refNo: json['RefNo'] as String,
      rowUCode: json['RowUCode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PageId': pageId,
      'Id': id,
      'Question': question,
      'QuestionDescription': questionDescription,
      'QuestionSelection': questionSelection,
      'QuestionTitle': questionTitle,
      'PriceType': priceType,
      'Amount': amount,
      'weightage': weightage,
      'QuestionId': questionId,
      'ListOptionAns': listOptionAns,
      'CheckStatus': checkStatus,
      'RefNo': refNo,
      'RowUCode': rowUCode,
    };
  }
}