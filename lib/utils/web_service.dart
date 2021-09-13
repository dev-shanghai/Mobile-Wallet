// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:dio_retry/dio_retry.dart';
// ;
// import 'package:flutter/foundation.dart';
// // import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import 'package:logging/logging.dart';

// /// a class for add default values to any apis http call
// class Service {
//   Service._privateConstructor();
//   static final Service instance = Service._privateConstructor();

//   //Dio dio;
//   bool isRetryCall = false;
//   //static Map<int, String> queueTimestamp = <int, String>{};

//   // Future<void> checkQueue(int timestamp) async {
//   // print('=====1');
//   // await Future.delayed(Duration(seconds: 5), () async {
//   //   print('=====2');

//   //if (queueTimestamp.containsKey(timestamp) &&
//   //   queueTimestamp.keys.first != timestamp) {
//   // print('=====3');

//   //  await checkQueue(timestamp);
//   // }
//   //     print('=====4');
//   //   });
//   //   print('=====5');
//   // }

//   Future<Dio> client() async {
//     Time().printTime();
//     // final int timestamp = DateTime.now().millisecondsSinceEpoch;
//     // queueTimestamp.putIfAbsent(timestamp, () => url);
//     // print('=====A');
//     // if (queueTimestamp.length > 1) {
//     //   print('=====B');
//     //   await checkQueue(timestamp);
//     // }
//     // print('=====C');

//     //if (dio == null)
//     Dio dio = Dio(); // with default Options
//     //else
//     // return dio;
//     final String baseUrl = await Shared().getEndPoint();
//     // Displaying logs
//     Logger.root.level = Level.ALL;
//     Logger.root.onRecord.listen((LogRecord record) {
//       print('${record.level.name}: ${record.time}: ${record.message}');
//     });

//     // Set default configs
//     dio.options.baseUrl = baseUrl;
//     dio.options.connectTimeout = 60000; //120s
//     dio.options.receiveTimeout = 60000;
//     dio.options.headers[HttpHeaders.contentTypeHeader] =
//         'application/json;charset=UTF-8';
//     dio.options.headers[HttpHeaders.acceptHeader] = 'application/json';
//     final String authorizationHeader = await Shared().getAuthorization();

//     dio.options.headers[HttpHeaders.authorizationHeader] = authorizationHeader;
    
//     //dio.interceptors.add(FlipperKitDioInterceptor());

//     dio.interceptors.add(LogInterceptor(
//         request: true,
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//         responseHeader: false));
//     //  dio.interceptors.add(PrettyDioLogger(
//     //       requestHeader: true,
//     //       requestBody: true,
//     //       responseBody: true,
//     //       responseHeader: false,
//     //       error: true,
//     //       compact: true,));

//     dio.interceptors.add(RetryInterceptor(
//         dio: dio,
//         logger: Logger('Retry http'),
//         options: const RetryOptions(
//           retries: 2, // Number of retries before a failure
//           retryInterval: Duration(seconds: 3), // Interval between each retry
//           // retryEvaluator: (error) =>  error.type != DioErrorType.CANCEL && nerror.type != DioErrorType.RESPONSE,
//           // Evaluating if a retry is necessary regarding the error. It is a good candidate for updating authentication token in case of a unauthorized error (be careful with concurrency though)
//         )));
//     HttpMetric metric;
//     dio.interceptors
//         .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
//       metric = FirebasePerformance.instance.newHttpMetric(
//           options.baseUrl + options.path,
//           options.method.toLowerCase().contains('get')
//               ? HttpMethod.Get
//               : HttpMethod.Post);

//       await metric.start();

//       final RequestOptions customOptions = await addAuthHeader(dio, options);
//       return customOptions;
//     }, onResponse: (Response<dynamic> response) async {
//       metric.httpResponseCode = response.statusCode;
//       await metric.stop();
//       //String url = response.request.path;
//       if (response.data.toString().toLowerCase().contains('expired token')) {
//         await LoginProvider().autoLogin();
//         return await retry(dio, response.request);
//       }
//       return response.data;
//     }, onError: (DioError e) async {
//       await metric.stop();
//       Crashlytics.instance.log(e.request.path);

//       // FlutterErrorDetails ee=FlutterErrorDetails()
//       //                       Crashlytics.instance
//       //                     .recordFlutterError(details)(e, s, context: 'as an example');
//     }));

//     return dio;
//   }

//   Future<RequestOptions> addAuthHeader(Dio dio, RequestOptions options) async {
//     String authorizationHeader = await Shared().getAuthorization();
//     if (authorizationHeader == null) {
//       dio.lock();
//       return LoginProvider().autoLogin().then((LoginModel model) async {
//         authorizationHeader = await Shared().getAuthorization();
//         options.headers[HttpHeaders.authorizationHeader] = authorizationHeader;
//         dio.options.headers[HttpHeaders.authorizationHeader] =
//             authorizationHeader;

//         dio.options.headers[HttpHeaders.contentTypeHeader] =
//             'application/json;charset=UTF-8';
//         dio.options.headers[HttpHeaders.acceptHeader] = 'application/json';

//         return options;
//       }).whenComplete(() => dio.unlock()); // unlock the dio
//     } else {
//       options.headers[HttpHeaders.authorizationHeader] = authorizationHeader;
//       dio.options.headers[HttpHeaders.authorizationHeader] =
//           authorizationHeader;

//       dio.options.headers[HttpHeaders.contentTypeHeader] =
//           'application/json;charset=UTF-8';
//       dio.options.headers[HttpHeaders.acceptHeader] = 'application/json';
//       return options;
//     }
//   }

//   void clearClient() {
//     //  dio == null;
//   }

//   Future<Response<dynamic>> retry(
//       Dio dio, RequestOptions requestOptions) async {
//     print('retry path:${requestOptions.path}');
//     final Options options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     isRetryCall = true;
//     return dio
//         .request<dynamic>(requestOptions.path,
//             data: requestOptions.data,
//             queryParameters: requestOptions.queryParameters,
//             options: options)
//         .whenComplete(() => isRetryCall = false);
//   }

//   String stringify(Map<String, dynamic> jsonMap) => json.encode(jsonMap);

//   dynamic  jsonify(dynamic jsonValue, {bool includeNull = false}) {
//     final Map<String, dynamic> map = <String, dynamic>{};
//     try {
//       if (jsonValue is String &&
//           json.decode(jsonValue) is Map<String, dynamic>) {
//         final Map<String, dynamic> tempMap = json.decode(jsonValue);
//         tempMap.removeWhere(
//             (String key, dynamic value) => !includeNull && value == null);
//         tempMap.forEach((String key, dynamic value) {
//           final dynamic jsonValue = jsonify(value, includeNull: includeNull);
//           tempMap.update(key, (dynamic existingValue) => jsonValue);
//         });
//         map.addAll(tempMap);
//       } else if (jsonValue is List<dynamic>) {
//         for (int i = 0; i < jsonValue.length; i++) {
//           jsonValue[i] = jsonify(jsonValue[i], includeNull: includeNull);
//         }
//         return jsonValue;
//       } else {
//         return jsonValue;
//       }
//     } on FormatException {
//       return jsonValue;
//     }
//     return map;
//   }
//   /*FormData generateFormData(Map<String, dynamic> map) {
//     Map<String, dynamic> temp = <String, dynamic>{};
//     map.forEach((String key, dynamic val) {
//       if (val is Requestable) {
//         temp.putIfAbsent(key, () => valtoData());
//       } else {
//         temp.putIfAbsent(key, () => val);
//       }
//     });
//     // print(json.encode(map));
//     return FormData.fromMap(map);

//     /* final FormData formData = FormData();
//     print(map);
//     map.forEach((String key, dynamic val) {
//       if (val is Requestable) {
//         formData.add(key, valtoData());
//       } else {
//         formData.add(key, val);
//       }
//     });
//     print(formData);
//     return formData;*/
//   }*/

//   /// default header for all apis
//   static const Map<String, String> defaultHeaders = <String, String>{
//     HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8',
//     //'User-Language':'ar'
//   };
// }