// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      addressName: json['addressName'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'addressName': instance.addressName,
    };

StoreLocation _$StoreLocationFromJson(Map<String, dynamic> json) =>
    StoreLocation(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$StoreLocationToJson(StoreLocation instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) => StoreInfo(
      category: json['category'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location:
          StoreLocation.fromJson(json['location'] as Map<String, dynamic>),
      storeurl: json['storeurl'] as String,
      storeaddress: json['storeaddress'] as String,
      benefit: json['benefit'] as String?,
    );

Map<String, dynamic> _$StoreInfoToJson(StoreInfo instance) => <String, dynamic>{
      'category': instance.category,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'storeurl': instance.storeurl,
      'storeaddress': instance.storeaddress,
      'benefit': instance.benefit,
    };

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] == null
          ? null
          : LoginError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'token': instance.token,
    };

LoginError _$LoginErrorFromJson(Map<String, dynamic> json) => LoginError(
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginErrorToJson(LoginError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

CardContent _$CardContentFromJson(Map<String, dynamic> json) => CardContent(
      cardNumber: json['cardNumber'] as String?,
      createdDate: json['createdDate'] as String?,
      modifiedDate: json['modifiedDate'] as String?,
      id: json['id'] as int?,
      balance: json['balance'] as String?,
      usage: json['usage'] as String?,
      price: json['price'] as String?,
      priceTime: json['priceTime'] as String?,
      cardYear: json['cardYear'] as String?,
      cardMonth: json['cardMonth'] as String?,
      cardCVC: json['cardCVC'] as String?,
      cardName: json['cardName'] as String?,
    );

Map<String, dynamic> _$CardContentToJson(CardContent instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'balance': instance.balance,
      'usage': instance.usage,
      'price': instance.price,
      'priceTime': instance.priceTime,
      'cardYear': instance.cardYear,
      'cardMonth': instance.cardMonth,
      'cardCVC': instance.cardCVC,
      'cardName': instance.cardName,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ClientMap implements ClientMap {
  _ClientMap(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://13.125.184.128:8080';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<StoreInfo>> getMapStore({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<StoreInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/location/find',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => StoreInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<StoreInfo>> getStoreSearch({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<StoreInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/location/namesearch',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => StoreInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<StoreInfo>> getMapGoodVibeStoreFind(
      {required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<StoreInfo>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/location/goodvibestorefind',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => StoreInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Location> getMapMyLocation({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Location>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/location/mylocation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Location.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ClientPerson implements ClientPerson {
  _ClientPerson(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://43.200.242.244:8080';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> signUp({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/signup',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<LoginInfo> login({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> delete({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/delete',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<CardContent>> getCardList({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CardContent>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/card/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CardContent.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<String> checkEmail({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/check/email',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> checkNickname({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/check/nickname',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> signUpCard({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/card/signup',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<CardContent>> checkUsage({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CardContent>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/usage/check',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CardContent.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<CardContent>> updateCard({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CardContent>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/usage/update',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CardContent.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CardContent> checkWeekUsage({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CardContent>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/usage/check/week',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CardContent.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CardContent> checkMonthUsage({required dynamic jsondata}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = jsondata;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CardContent>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/usage/check/month',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CardContent.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
