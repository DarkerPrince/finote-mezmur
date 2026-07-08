import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getClient() {
  final httpLink = HttpLink(
    'https://wanted-donkey-72.hasura.app/v1/graphql', // your Hasura endpoint
    defaultHeaders: {
      'x-hasura-admin-secret': 'QH1yTVZPjL3KYM5X1pLema06CALYokS786F535L7VVHo3JivKpUDN5F3IR8xDP5a', // if using admin secret
    },
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
