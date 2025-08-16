import 'dart:convert';
import 'dart:io';
import 'package:el_webapi_api/el_webapi_api.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() async {
  final router = Router();

  // POST handler for /elapi/v1
  router.post('http://150.65.179.132:7000/elapi/v1/<ignored|.*>', (Request request) async {
    final body = await request.readAsString();
    final data = json.decode(body);

    final response = {
      'message': 'Data received successfully (POST)!',
      'data': data,
    };

    return Response.ok(json.encode(response), headers: {
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    });
  });

  //GET handler for /elapi/v1
  router.get('http://150.65.179.132:7000/elapi/v1/devices/', (Request request) async {
    final body = await request.readAsString();
    final data = json.decode(body);

    final response = {
      'message': 'Data received successfully (POST)!',
      'data': data,
    };

    return Response.ok(json.encode(response), headers: {
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    });
  });
    router.get('http://150.65.179.132:7000/elapi/v1/devices/<ignored|.*>', (Request request) async {
    final body = await request.readAsString();
    final data = json.decode(body);

    final response = {
      'message': 'Data received successfully (POST)!',
      'data': data,
    };

    return Response.ok(json.encode(response), headers: {
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    });
  });

final handler = Pipeline()
    .addMiddleware(logRequests())
    .addMiddleware(corsHeaders(headers: {
      'Access-Control-Allow-Origin': '*', // Or specify your frontend origin
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
    }))
    .addHandler(router);
router.options('/<ignored|.*>', (Request request) {
  return Response.ok('', headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
  });
});


  final server = await serve(handler, '0.0.0.0', 7000);
  print('Backend running at http://${server.address.host}:${server.port}');
}
