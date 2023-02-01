// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse()
  ..status = json['status'] as String
  ..code = json['code'] as String?
  ..message = json['message'] as String?
  ..articles = (json['articles'] as List<dynamic>?)
      ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'articles': instance.articles,
    };
