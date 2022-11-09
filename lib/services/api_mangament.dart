import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int delaySecond = 2;
int internetDelay = 5;
ApiManagement apiQueue = ApiManagement();

class ApiManagement {
  Timer timer = Timer(Duration(seconds: delaySecond), () {});
  Stopwatch stopwatch = Stopwatch();
  ApiManagement() {
    addListener();
    checkForInternet();
  }

  // create min priority queue
  static Queue<ApiRequest> queue = Queue<ApiRequest>();
  // get all requests
  static List<ApiRequest> get requests => queue.toList();

  // add request to queue
  static void add(ApiRequest request) {
    if (!queue.contains(request)) {
      queue.add(request);
    }
  }

  // execute all requests in queue
  static Future<void> executeAll() async {
    while (queue.isNotEmpty) {
      final request = queue.removeFirst();
      await request.execute();
    }
  }

  // remove if request is already completed
  static void remove(ApiRequest request) {
    queue.remove(request);
  }

  // clear all requests
  static void clear() {
    queue.clear();
  }

  // make a execute loop that check for errors and retry
  Future<void> executeAllWithRetry() async {
    // iterate over all requests
    for (final request in requests) {
      // execute request
      await request.execute();
      // check if request is completed
      if (!request.hasError) {
        // remove request from queue
        remove(request);
      } else {
        // retry request
        await request.retry();
      }
    }
  }

  // add listener for check error requests
  void addListener() {
    // check for error requests every 5 seconds
    if (!timer.isActive) {
      timer = Timer.periodic(Duration(seconds: delaySecond), (timer) {
        // check if there is any error request
        if (requests.any((request) => request.hasError)) {
          // execute all requests
          executeAllWithRetry();
        }
      });
    }
  }

  checkForInternet() async {
    // connectivity stream
    final connectivityStream = Connectivity().onConnectivityChanged;
    // listen for connectivity changes
    connectivityStream.listen((connectivityResult) async {
      // check if there is no internet connection
      if (connectivityResult == ConnectivityResult.none) {
        // stop timer
        timer.cancel();
      } else {
        // start timer
        addListener();
      }
    });
  }
}

class ApiRequest<T> {
  final String baseUrl;
  final String path;
  final ApiTypes method;
  final dynamic body;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParameters;
  final Function? onSuccess;
  final Function? onError;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool hasError;

  ApiRequest({
    required this.baseUrl,
    required this.path,
    required this.method,
    this.body,
    this.headers,
    this.queryParameters,
    this.onSuccess,
    this.onError,
    this.hasError = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiRequest &&
          runtimeType == other.runtimeType &&
          baseUrl == other.baseUrl &&
          path == other.path &&
          method == other.method &&
          body == other.body &&
          headers == other.headers &&
          queryParameters == other.queryParameters;

  @override
  int get hashCode =>
      baseUrl.hashCode ^
      path.hashCode ^
      method.hashCode ^
      body.hashCode ^
      headers.hashCode ^
      queryParameters.hashCode;

  @override
  String toString() {
    return 'ApiRequest{baseUrl: $baseUrl,path: $path, method: $method, body: $body, headers: $headers, queryParameters: $queryParameters}';
  }

  //get request
  ApiRequest get({
    required int priority,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return ApiRequest(
      baseUrl: url,
      path: path,
      method: ApiTypes.GET,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  //post request
  ApiRequest post({
    required int priority,
    required String url,
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return ApiRequest(
      baseUrl: url,
      path: path,
      method: ApiTypes.POST,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  //put request
  ApiRequest put({
    required int priority,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return ApiRequest(
      baseUrl: url,
      path: path,
      method: ApiTypes.PUT,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  //delete request
  ApiRequest delete({
    required int priority,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return ApiRequest(
      baseUrl: url,
      path: path,
      method: ApiTypes.DELETE,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  //send get request using http.get
  Future<dynamic> sendGetRequest() async {
    try {
      ApiManagement.add(this);
      String query;
      if (queryParameters != null) {
        query = Uri(queryParameters: queryParameters).query;
      } else {
        query = '';
      }
      final response = await http.get(
        Uri.parse('$baseUrl$path?$query'),
        headers: headers,
      );
      log('GET REQUEST: ${response.statusCode}');
      if (response.statusCode == HttpStatus.ok) {
        ApiManagement.remove(this);
        return jsonDecode(response.body);
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
    }
    return null;
  }

  //send post request using http.post
  Future<dynamic?> sendPostRequest() async {
    try {
      ApiManagement.add(this);
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(baseUrl + path),
        headers: headers,
        body: body,
      );
      log('POST REQUEST: ${response.statusCode}');
      isLoading.value = false;
      if (response.statusCode == 200) {
        ApiManagement.remove(this);
        return jsonDecode(response.body);
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
      print(e);
    }
    return null;
  }

  //send put request using http.put
  Future<T?> sendPutRequest() async {
    try {
      ApiManagement.add(this);
      isLoading.value = true;
      final response = await http.put(
        Uri.parse(baseUrl + path),
        headers: headers,
        body: body,
      );
      log('PUT REQUEST: ${response.statusCode}');
      isLoading.value = false;
      if (response.statusCode == HttpStatus.ok) {
        ApiManagement.remove(this);
        return response.body as T;
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
    }
    return null;
  }

  //send delete request using http.delete
  Future<T?> sendDeleteRequest() async {}

  //execute request
  Future<dynamic> execute() async {
    if (method == ApiTypes.GET) {
      return await sendGetRequest();
    } else if (method == ApiTypes.POST) {
      return await sendPostRequest();
    } else if (method == ApiTypes.PUT) {
      return await sendPutRequest();
    } else if (method == ApiTypes.DELETE) {
      return await sendDeleteRequest();
    }
  }

  Future<T?> retry() async {
    // retry request
    return await execute();
  }
}

enum ApiTypes {
  GET,
  POST,
  PUT,
  DELETE,
}
