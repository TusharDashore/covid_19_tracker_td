import 'dart:convert';
import 'package:covid_19_tracker_td/Model/WorldStateModel.dart';
import 'package:http/http.dart' as http;

import 'app_url.dart';

class StatesServices{
  Future<WorldStateModel> fetchworldStatesRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi () async{

    final response = await http.get(Uri.parse(AppUrl.countriesListApi));
    var data;
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }
}