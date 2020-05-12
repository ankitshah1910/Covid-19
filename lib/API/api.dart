import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Urls {
  static const BASE_URL_API = "https://covid-193.p.rapidapi.com/";

  static const LIST_COUNTRY = BASE_URL_API + "countries";
  static const LIST_DATA = BASE_URL_API + "statistics";

}

class list_country {
  static Future<List> getdata() async {
    final response = await http.get('${Urls.LIST_COUNTRY}',
        headers:{
          "x-rapidapi-host": "covid-193.p.rapidapi.com",
          "x-rapidapi-key":"ddb5d7b3camsh8f3261ff1b7ab38p1b3f22jsn3f2def206e59"
        }
    );
    Map data;
    List userdata;

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      userdata = data["response"];
      userdata.insert(0,"All");

      return userdata;
    } else {
      print("called1");
      return null;
    }
  }
}
class list_data {
  static Future<List> getdata() async {
    final response = await http.get('${Urls.LIST_DATA}',
        headers:{
          "x-rapidapi-host": "covid-193.p.rapidapi.com",
          "x-rapidapi-key":"ddb5d7b3camsh8f3261ff1b7ab38p1b3f22jsn3f2def206e59"
        }
    );
    Map data;
    List userdata;

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      userdata = data["response"];

      return userdata;
    } else {
      print("called2");
      return null;
    }
  }
}
