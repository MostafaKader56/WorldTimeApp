import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
    String? location;
    String time = '';
    String? flag;
    String? url; // location url for api end point
    bool? isDayTime; // true then it's date time

    WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{
    
    try{
      // Make the Request
    // Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/Europe/London'));
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    // print(data);

    // get propities from data
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(0, 3);

    /*

    Ternary operator descriptrin
    value = condtion ? v1 : v2 
    if the condition returns true then value = v1 if it's returning false then the value = v2.

    */

    // create DateTime Object 
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

    time = DateFormat.jm().format(now);
    }
    catch(e){
      print('cauth error: $e');
      time = 'Could not get time data.';
    }

  }

}