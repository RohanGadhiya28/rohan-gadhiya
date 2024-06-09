import 'dart:convert';
/// Status : 200
/// Message : "OK"
/// Result : [{"Name":"BELVEDERE TOURMALINE","PriceCode":"E39","ImageName":"http://esptiles.imperoserver.in/Admin/Files/ProductImage/17c6fd76-6f39-46f1-9ffb-3a46720d9cfe.png","Id":525},{"Name":"BELVEDERE WHISPER SAGE","PriceCode":"E39","ImageName":"http://esptiles.imperoserver.in/Admin/Files/ProductImage/0f92ea41-5532-48d9-8b48-2293a3c5b7f5.png","Id":527},{"Name":"BELVEDERE WHITE","PriceCode":"E39","ImageName":"http://esptiles.imperoserver.in/Admin/Files/ProductImage/e7aabcf7-406a-4091-92f7-acad5fdbe15c.png","Id":521}]

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));
String productListModelToJson(ProductListModel data) => json.encode(data.toJson());
class ProductListModel {
  ProductListModel({
      int? status, 
      String? message, 
      List<Result>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  ProductListModel.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['Result'] != null) {
      _result = [];
      json['Result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Result>? _result;

  int? get status => _status;
  String? get message => _message;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_result != null) {
      map['Result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Name : "BELVEDERE TOURMALINE"
/// PriceCode : "E39"
/// ImageName : "http://esptiles.imperoserver.in/Admin/Files/ProductImage/17c6fd76-6f39-46f1-9ffb-3a46720d9cfe.png"
/// Id : 525

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? name, 
      String? priceCode, 
      String? imageName, 
      int? id,}){
    _name = name;
    _priceCode = priceCode;
    _imageName = imageName;
    _id = id;
}

  Result.fromJson(dynamic json) {
    _name = json['Name'];
    _priceCode = json['PriceCode'];
    _imageName = json['ImageName'];
    _id = json['Id'];
  }
  String? _name;
  String? _priceCode;
  String? _imageName;
  int? _id;

  String? get name => _name;
  String? get priceCode => _priceCode;
  String? get imageName => _imageName;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['PriceCode'] = _priceCode;
    map['ImageName'] = _imageName;
    map['Id'] = _id;
    return map;
  }

}