// This class is The Grapql Provider where link and graphql client is inliazed and called in  class

import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlProvider {
  static final HttpLink httpLink = HttpLink(
      "https://bright-hare-51.hasura.app/v1/graphql",
      defaultHeaders: {
        "x-hasura-admin-secret":
            "jTJLjELnSB5qUglz8YY6at03Im850gtiYRQy3X3Kyyw9W4Bsu0dvGcXpm6Vxl2Uz"
      });

  final ValueNotifier<GraphQLClient> client =
      ValueNotifier<GraphQLClient>(GraphQLClient(
          link: httpLink,
          cache: GraphQLCache(
            dataIdFromObject: (object) {
              const Text("Hello");
              return null;
            },
          )));

  GraphQLClient clientToQuery() {
    return GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(
          dataIdFromObject: (object) {
            const Text("Cache");
            return null;
          },
        ));
  }
}
