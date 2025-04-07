class CommonFilterModel {
  final List<Processor> processors;
  final List<Ram> rams;
  final List<Rom> roms;
  final List<BrandModel> brands;
  final List<ColorOptionModel> colors;
  final List<DisplayModel> displays;
  final List<BatteryModel> batteries;
  final List<FrontCameraModel> frontCameras;
  final List<RearCameraModel> rearCameras;

  CommonFilterModel({
    required this.processors,
    required this.rams,
    required this.roms,
    required this.brands,
    required this.colors,
    required this.displays,
    required this.batteries,
    required this.frontCameras,
    required this.rearCameras,
  });

  factory CommonFilterModel.fromJson(Map<String, dynamic> json) {
    return CommonFilterModel(
      processors:
          List<Processor>.from(json["Table"].map((x) => Processor.fromJson(x))),
      rams: List<Ram>.from(json["Table1"].map((x) => Ram.fromJson(x))),
      roms: List<Rom>.from(json["Table2"].map((x) => Rom.fromJson(x))),
      brands: List<BrandModel>.from(
          json["Table3"].map((x) => BrandModel.fromJson(x))),
      colors: List<ColorOptionModel>.from(
          json["Table4"].map((x) => ColorOptionModel.fromJson(x))),
      displays: List<DisplayModel>.from(
          json["Table5"].map((x) => DisplayModel.fromJson(x))),
      batteries: List<BatteryModel>.from(
          json["Table6"].map((x) => BatteryModel.fromJson(x))),
      frontCameras: List<FrontCameraModel>.from(
          json["Table7"].map((x) => FrontCameraModel.fromJson(x))),
      rearCameras: List<RearCameraModel>.from(
          json["Table8"].map((x) => RearCameraModel.fromJson(x))),
    );
  }
}

// Define sub-models like Processor, Ram, etc.

class Processor {
  final int id;
  final String processor;
  Processor({required this.id, required this.processor});
  factory Processor.fromJson(Map<String, dynamic> json) => Processor(
        id: json["Id"],
        processor: json["Processor"],
      );
}

class Ram {
  final int id;
  final String ramName;
  Ram({required this.id, required this.ramName});
  factory Ram.fromJson(Map<String, dynamic> json) => Ram(
        id: json["id"],
        ramName: json["RamName"],
      );
}

class Rom {
  final int id;
  final String romName;
  Rom({required this.id, required this.romName});
  factory Rom.fromJson(Map<String, dynamic> json) => Rom(
        id: json["id"],
        romName: json["RomName"],
      );
}

class BrandModel {
  final int id;
  final String? brandImage;
  final String brandName;
  final String? bToC;
  final String? offerImage;

  BrandModel({
    required this.id,
    this.brandImage,
    required this.brandName,
    this.bToC,
    this.offerImage,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      brandImage: json['BrandImage'],
      brandName: json['BrandName'],
      bToC: json['BToC'],
      offerImage: json['OfferImage'],
    );
  }
}

class ColorOptionModel {
  final int id;
  final String colorName;

  ColorOptionModel({
    required this.id,
    required this.colorName,
  });

  factory ColorOptionModel.fromJson(Map<String, dynamic> json) {
    return ColorOptionModel(
      id: json['id'],
      colorName: json['ColorName'],
    );
  }
}

class DisplayModel {
  final int id;
  final String display;

  DisplayModel({
    required this.id,
    required this.display,
  });

  factory DisplayModel.fromJson(Map<String, dynamic> json) {
    return DisplayModel(
      id: json['Id'],
      display: json['Display'],
    );
  }
}

class BatteryModel {
  final int id;
  final String battery;

  BatteryModel({
    required this.id,
    required this.battery,
  });

  factory BatteryModel.fromJson(Map<String, dynamic> json) {
    return BatteryModel(
      id: json['Id'],
      battery: json['Battery'],
    );
  }
}

class FrontCameraModel {
  final int id;
  final String frontCamera;

  FrontCameraModel({
    required this.id,
    required this.frontCamera,
  });

  factory FrontCameraModel.fromJson(Map<String, dynamic> json) {
    return FrontCameraModel(
      id: json['Id'],
      frontCamera: json['FrontCamera'],
    );
  }
}

class RearCameraModel {
  final int id;
  final String rearCamera;

  RearCameraModel({
    required this.id,
    required this.rearCamera,
  });

  factory RearCameraModel.fromJson(Map<String, dynamic> json) {
    return RearCameraModel(
      id: json['Id'],
      rearCamera: json['RearCamera'],
    );
  }
}
