import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'http://13.125.184.128:8080')
abstract class ClientMap {
  factory ClientMap(Dio dio, {String baseUrl}) = _ClientMap;

  @GET('/location/find')
  Future<List<StoreInfo>> getMapStore({@Body() required jsondata});

  @GET('/location/namesearch')
  Future<List<StoreInfo>> getStoreSearch({@Body() required jsondata});

  @GET('/location/goodvibestorefind')
  Future<List<StoreInfo>> getMapGoodVibeStoreFind({@Body() required jsondata});

  @GET('/location/mylocation')
  Future<Location> getMapMyLocation({@Body() required jsondata});
}

@RestApi(baseUrl: 'http://43.200.242.244:8080')
abstract class ClientPerson {
  factory ClientPerson(Dio dio, {String baseUrl}) = _ClientPerson;

  @POST('/user/signup')
  Future<String> signUp({@Body() required jsondata});

  @POST('/user/login')
  Future<LoginInfo> login({@Body() required jsondata});

  @POST('/user/delete')
  Future<String> delete({@Body() required jsondata});

  @POST('/user/card/list')
  Future<List<CardContent>> getCardList({@Body() required jsondata});

  @POST('/check/email')
  Future<String> checkEmail({@Body() required jsondata});

  @POST('/check/nickname')
  Future<String> checkNickname({@Body() required jsondata});

  @POST('/user/card/signup')
  Future<String> signUpCard({@Body() required jsondata});

  @POST('/usage/check')
  Future<List<CardContent>> checkUsage({@Body() required jsondata});

  @POST('/usage/update')
  Future<List<CardContent>> updateCard({@Body() required jsondata});

  @POST('/usage/check/week')
  Future<CardContent> checkWeekUsage({@Body() required jsondata});

  @POST('/usage/check/month')
  Future<CardContent> checkMonthUsage({@Body() required jsondata});
}

@JsonSerializable()
class Location {
  Location({
    required this.addressName,
  });
  String addressName;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class StoreLocation {
  StoreLocation({
    required this.x,
    required this.y,
    required this.type,
    required this.coordinates,
  });
  double x;
  double y;
  String type;
  List<double> coordinates;

  factory StoreLocation.fromJson(Map<String, dynamic> json) =>
      _$StoreLocationFromJson(json);
  Map<String, dynamic> toJson() => _$StoreLocationToJson(this);
}

@JsonSerializable()
class StoreInfo {
  StoreInfo(
      {required this.category,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.location,
      required this.storeurl,
      required this.storeaddress,
      this.benefit});

  String category;
  String name;
  double latitude;
  double longitude;
  StoreLocation location;
  String storeurl;
  String storeaddress;
  String? benefit;

  factory StoreInfo.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StoreInfoToJson(this);
}

@JsonSerializable()
class LoginInfo {
  LoginInfo({
    required this.success,
    required this.data,
    required this.error,
  });

  bool success;
  LoginData? data;
  LoginError? error;

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}

@JsonSerializable()
class LoginData {
  LoginData({
    required this.token,
  });

  String? token;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class LoginError {
  LoginError({
    required this.code,
    required this.message,
  });

  int? code;
  String? message;

  factory LoginError.fromJson(Map<String, dynamic> json) =>
      _$LoginErrorFromJson(json);
  Map<String, dynamic> toJson() => _$LoginErrorToJson(this);
}

@JsonSerializable()
class CardContent {
  CardContent(
      {required this.cardNumber,
      this.createdDate,
      this.modifiedDate,
      this.id,
      this.balance,
      this.usage,
      this.price,
      this.priceTime,
      this.cardYear,
      this.cardMonth,
      this.cardCVC,
      this.cardName});

  String? createdDate;
  String? modifiedDate;
  int? id;
  String? cardNumber;
  String? balance;
  String? usage;
  String? price;
  String? priceTime;

  String? cardYear;
  String? cardMonth;
  String? cardCVC;
  String? cardName;

  factory CardContent.fromJson(Map<String, dynamic> json) =>
      _$CardContentFromJson(json);
  Map<String, dynamic> toJson() => _$CardContentToJson(this);
}
