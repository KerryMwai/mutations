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
