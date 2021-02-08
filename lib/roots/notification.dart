




import 'dart:convert';

import 'package:http/http.dart';
class MyNotification{


  Future<bool> sendFcmMessage(String title, String message) async {
try {

var url = 'https://fcm.googleapis.com/fcm/send';
var header = {
"Content-Type": "application/json",
"Authorization":
"key=AAAAggu222A:APA91bEDR1-PYD9peF8gcYk4iIKc61S9GvrGYi5abPivHg4JIVXj1JuGQZW86pgBybGp_0KwuutIMZb6NsQTjnqjvVcyFX-eDV80lBTXsHr6C8_h7ZXWCDXRySw0_ndofthVZCXjFOzY",
};
var request = {
"notification": {
"title": title,
"text": message,
"sound": "default",
"color": "#990000",
},
"priority": "high",
"to": "/topics/all",
};

var client = new Client();
var response =
await client.post(url, headers: header, body: json.encode(request));
print("notification sent sucssesfully");
return true;
} catch (e, s) {
print(e);
return false;
}}
}