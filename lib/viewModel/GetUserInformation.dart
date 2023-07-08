import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_infromation_bloc/model/UserModel.dart';

class GetUserInformation {

  String userUrl = 'https://reqres.in/api/users';

  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<UserModel> getUserDetails(int userID) async {
    Response response = await get(Uri.parse('$userUrl/$userID'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}