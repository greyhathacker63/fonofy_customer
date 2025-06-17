import 'dart:convert';

SellQuestion sellQuestionFromJson(String str) => SellQuestion.fromJson(json.decode(str));

String sellQuestionToJson(SellQuestion data) => json.encode(data.toJson());

class SellQuestion {
    bool? status;
    String? message;
    List<Datum>? data;

    SellQuestion({
        this.status,
        this.message,
        this.data,
    });

    factory SellQuestion.fromJson(Map<String, dynamic> json) => SellQuestion(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    dynamic pageId;
    String? pageTitle;
    String? refNo;
    dynamic rowUCode;
    List<Question>? questions;

    Datum({
        this.pageId,
        this.pageTitle,
        this.refNo,
        this.rowUCode,
        this.questions,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pageId: json["PageId"],
        pageTitle: json["PageTitle"],
        refNo: json["RefNo"],
        rowUCode: ["RowUCode"],
        questions: json["Questions"] == null ? [] : List<Question>.from(json["Questions"]!.map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "PageId": pageId,
        "PageTitle": pageTitle,
        "RefNo": refNo,
        "RowUCode": [rowUCode],
        "Questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
    };
}

class Question {
    String? questionId;
    String? question;
    String? questionDescription;
    String? refNo;
    dynamic rowUCode;
    List<Option>? options;

    Question({
        this.questionId,
        this.question,
        this.questionDescription,
        this.refNo,
        this.rowUCode,
        this.options,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["QuestionId"],
        question: json["Question"],
        questionDescription: json["QuestionDescription"],
        refNo: json["RefNo"],
        rowUCode: ["RowUCode"],
        options: json["Options"] == null ? [] : List<Option>.from(json["Options"]!.map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "QuestionId": questionId,
        "Question": question,
        "QuestionDescription": questionDescription,
        "RefNo": refNo,
        "RowUCode": [rowUCode],
        "Options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    };
}

class Option {
    dynamic pageId;
    dynamic sellQuestionId;
    String? questionSelection;
    String? questionTitle;
    String? priceType;
    dynamic amount;
    double? weightage;
    String? questionId;
    String? listOptionAns;
    String? checkStatus;
    String? refNo;
    dynamic  rowUCode;

    Option({
        this.pageId,
        this.sellQuestionId,
        this.questionSelection,
        this.questionTitle,
        this.priceType,
        this.amount,
        this.weightage,
        this.questionId,
        this.listOptionAns,
        this.checkStatus,
        this.refNo,
        this.rowUCode,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        pageId: json["PageId"],
        sellQuestionId: json["SellQuestionId"],
        questionSelection:json ["QuestionSelection"],
        questionTitle: json["QuestionTitle"],
        priceType: json["PriceType"],
        amount: json["Amount"],
        weightage: json["weightage"]?.toDouble(),
        questionId: json["QuestionId"],
        listOptionAns: json["ListOptionAns"],
        checkStatus: json["CheckStatus"],
        refNo: json["RefNo"],
        rowUCode:json["RowUCode"],
    );

    Map<String, dynamic> toJson() => {
        "PageId": pageId,
        "SellQuestionId": sellQuestionId,
        "QuestionSelection": questionSelection,
        "QuestionTitle": questionTitle,
        "PriceType":priceType,
        "Amount": amount,
        "weightage": weightage,
        "QuestionId": questionId,
        "ListOptionAns": listOptionAns,
        "CheckStatus": checkStatus,
        "RefNo": refNo,
        "RowUCode": rowUCode,
    };
}

