import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mutation/core/model/user.dart';

class UserInteraction extends ChangeNotifier {
  String userCreationmutation = """
mutation createUser(\$input: CreateUserInput!){
  createUser(input:\$input){
  id
  username
  name
  email
  phone
}
}
""";

  String getUserQuery = """
query (\$id: Int){
    getUserInfo(id: \$id) {
      id,
      name,
      username,
      email
    }
  }

""";

  String getAllUsersQuery = """
query{
  users{
    data{
      id
      name
      username
      email
    	phone
    }
  }
}
""";
  HttpLink link = HttpLink("https://graphqlzero.almansi.me/api");

  Future<bool> createUser(User user) async {
    GraphQLClient client =
        GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));

    QueryResult queryResult = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(userCreationmutation),
        variables: {'input': user}));

    if (queryResult.hasException) {
      return false;
    } else {
      return true;
    }
  }

  Future<Map<String, dynamic>> getUser({int? id}) async {
    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ), // cache
    );
    QueryResult queryResult = await qlClient.query(
      // this is get so query methos
      QueryOptions(
          // one more thing if you notice  here when we use query method
          //  we use QueryOptions , for mutate
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(
            getUserQuery, // let'see string
          ),
          variables: {
            "id": id, // passing id in varibles
          }),
    );

    return queryResult.data?['getUserInfo'] ??
        {}; // i am getting json respone in getUserInfo which i am returning
  }

  List _users = [];

  UnmodifiableListView get allusers => UnmodifiableListView(_users);

  Future getAllUsers() async {
    // this is api call for getting all users
    GraphQLClient qlClient = GraphQLClient(
      // same client create
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
    QueryResult queryResult = await qlClient.query(
      // here it's get type so using query method
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(
          getAllUsersQuery, // let's see query string
        ),
      ),
    );

    _users = (queryResult.data!['users']['data'] as List)
        .map((user) => User.fromJson(user))
        .toList();
    print(_users.length);
    notifyListeners();
  }
}
