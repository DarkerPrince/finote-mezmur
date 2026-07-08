import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'GraphqlClient.dart';
import 'query_mutation.dart'; // your client file

Future<void> fetchAndStoreMezmurs() async {
  final client = getClient();

  final result = await client.query(
    QueryOptions(document: gql(fetchMezmursQuery)),
  );

  if (result.hasException) {
    print('GraphQL Error: ${result.exception.toString()}');
    return;
  }

  final data = result.data?['finote_mezmur'];
  if (data == null) {
    print('No data received from Hasura');
    return;
  }

  // Convert to JSON string
  final jsonString = jsonEncode(data);

  // Get app documents directory
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/mezmurs.json');

  // Save JSON to file
  await file.writeAsString(jsonString);

  print('Mezmurs saved to: ${file.path}');
}
