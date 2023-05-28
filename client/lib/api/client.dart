import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'http://13.125.184.128:8080')
abstract class ClientMap {
  factory ClientMap(Dio dio, {String baseUrl}) = _ClientMap;

  @GET('/location/find')
  Future<String> getMapLocation({@Body() required jsondata});

  @GET('/location/namesearch')
  Future<String> getMapNameSearch({@Body() required jsondata});

  @GET('/location/goodvibestorefind')
  Future<String> getMapGoodVibeStoreFind({@Body() required jsondata});
}

@RestApi(baseUrl: 'http://43.200.242.244:8080')
abstract class ClientPerson {
  factory ClientPerson(Dio dio, {String baseUrl}) = _ClientPerson;

  @POST('/user/signup')
  Future<String> signUp({@Body() required jsondata});

  @POST('/user/login')
  Future<String> login({@Body() required jsondata});

  @POST('/check/email')
  Future<String> checkEmail({@Body() required jsondata});

  @POST('/check/nickname')
  Future<String> checkNickname({@Body() required jsondata});
}
