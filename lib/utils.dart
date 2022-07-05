// API Utils
import 'dart:convert';

String apiBaseUrlGlobal = "https://booking.2micoaching.com/index.php/api/v1/";
String apiServiceUrlGlobal = apiBaseUrlGlobal + "services";
String username = "sysadmin";
String password = "Qwerty@123";
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
