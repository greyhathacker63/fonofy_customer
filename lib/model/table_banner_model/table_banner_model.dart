// class TableBannerModel {
//   List<TableModel>? bnnerImage;
//
//   TableBannerModel({this.bnnerImage});
//
//   factory TableBannerModel.fromJson(Map<String, dynamic> json) {
//     var list = json['BnnerImage'] as List;
//     List<TableModel> banners = list.map((item) => TableModel.fromJson(item)).toList();
//     return TableBannerModel(bnnerImage: banners);
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'BnnerImage': bnnerImage?.map((x) => x.toJson()).toList(),
//   //   };
//   // }
// }
//
// class TableModel {
//   int? id;
//   String? title;
//   String? tagLine;
//   bool? isActive;
//   int? sequenceId;
//   String? ramdomCode;
//   String? bnnerImage;
//   String? cmpCode;
//   bool? status;
//   bool? isDeleted;
//   DateTime? createdDate;
//   int? createdBy;
//   DateTime? updatedDate;
//   int? updatedBy;
//
//   TableModel({
//     this.id,
//     this.title,
//     this.tagLine,
//     this.isActive,
//     this.sequenceId,
//     this.ramdomCode,
//     this.bnnerImage,
//     this.cmpCode,
//     this.status,
//     this.isDeleted,
//     this.createdDate,
//     this.createdBy,
//     this.updatedDate,
//     this.updatedBy,
//   });
//
//   factory TableModel.fromJson(Map<String, dynamic> json) {
//     return TableModel(
//       id: json['Id'],
//       title: json['Title'],
//       tagLine: json['TagLine'],
//       isActive: json['IsActive'],
//       sequenceId: json['SequenceId'],
//       ramdomCode: json['Ramdom_Code'],
//       bnnerImage: json['BnnerImage'],
//       cmpCode: json['Cmp_Code'],
//       status: json['Status'],
//       isDeleted: json['Isdeleted'],
//       createdDate: json['CreatedDate'] != null ? DateTime.tryParse(json['CreatedDate']) : null,
//       createdBy: json['Createdby'],
//       updatedDate: json['UpdatedDate'] != null ? DateTime.tryParse(json['UpdatedDate']) : null,
//       updatedBy: json['UpdatedBy'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Id': id,
//       'Title': title,
//       'TagLine': tagLine,
//       'IsActive': isActive,
//       'SequenceId': sequenceId,
//       'Ramdom_Code': ramdomCode,
//       'BnnerImage': bnnerImage,
//       'Cmp_Code': cmpCode,
//       'Status': status,
//       'Isdeleted': isDeleted,
//       'CreatedDate': createdDate?.toIso8601String(),
//       'Createdby': createdBy,
//       'UpdatedDate': updatedDate?.toIso8601String(),
//       'UpdatedBy': updatedBy,
//     };
//   }
// }
