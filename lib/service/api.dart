import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiConnect {
  // String url = 'http://192.168.1.148:8080/';
  getUrl()async{
    final prefs = await SharedPreferences.getInstance();
    final String? url = prefs.getString('url');
    final String port = prefs.getString('port') ?? '8080';

    if(url != null){
      return "$url:$port";
    }
    return 'http://192.168.1.148:8080/';
  }
  getStateServer()async{
    var url = await getUrl();
    if(url != -1) {
      try{
      http.Response responseStatus =
        await http.get(Uri.parse(url));
        return 1;
    }catch(e){
      return -1;
    }
    }else {
      return -11;
    }
  }
  getStatusDevice(int pin) async {
    var url = await getUrl();
    if(url != -1) {
      try{
    http.Response responseStatus =
        await http.get(Uri.parse('$url/status?pin=${pin.toString()}'));
    var data = json.decode(responseStatus.body);
    return data[pin.toString()];
    }catch(e){
      return -1;
    }
    }
  }

  onDevice(int pin) async {
    var url = await getUrl();
    if(url != -1) {
      await http.get(Uri.parse('$url/on?pin=${pin.toString()}'));
    }
  }

  offDevice(int pin) async {
    var url = await getUrl();
    if(url != -1) {
      await http.get(Uri.parse('$url/off?pin=${pin.toString()}'));
    }
  }

  getTemp(int roomNum)async{
    var url = await getUrl();
    if(url != -1) {
      try{
    http.Response response = await http.get(Uri.parse('$url/timp?room_num=$roomNum'));
      var data = json.decode(response.body);
      return data['Timp'];
    }catch(e){
      print(e);
      return 0;
    }
    }
  }
}
