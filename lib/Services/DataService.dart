import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NetworkService with ChangeNotifier{

  /// UserName Present Or Not
  bool _isusernamepresent = false;
  bool get isusernamepresent => _isusernamepresent;
  set isusernamepresent(bool value) {
    _isusernamepresent = value;
    notifyListeners();
  }

  /// UserName Initialization
  static String _username = "";
  String get username => _username;
  set username(String value) {
    _username = value;
    notifyListeners();
  }


  SaveUserName(String name) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("UserName", [name,"true"]);
    isusernamepresent=true;
    notifyListeners();
  }

  // final String appId = '67832901';  // Replace with your Edamam App ID
  // final String apiKey = '55d93ab0c1429eb06c085062f07933cf';  // Replace with your Edamam API Key
  // final String userId = '562c0db9';  // Replace with your Edamam User ID
  //
  // Future<Map<String, dynamic>> fetchDietPlan({
  //   required String dietType,   // vegetarian or non-vegetarian
  //   required String BMI,
  //   required String weight,
  //   required String height,
  //   required String age,
  // }) async {
  //   final String url = 'https://api.edamam.com/api/recipes/v2?type=public&q=$dietType&app_id=$appId&app_key=$apiKey';
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Edamam-Account-User': userId,  // Add the Edamam-Account-User header here
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       print("Real Data ${data}");
  //       return data;
  //     } else {
  //       print("Error With Status Code: ${response.statusCode} And Message: ${response.body}");
  //       throw Exception('Failed to load diet plan');
  //     }
  //   } catch (error) {
  //     print("Error IN Catch: $error");
  //     throw Exception('Error fetching data: $error');
  //   }
  // }

}