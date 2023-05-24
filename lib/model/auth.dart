import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/model/HTTPEXPCTION.dart';

class Auth with ChangeNotifier {
  String? _token="";
  DateTime? _expiryDate=DateTime.now();
  String? _userId="";
  Timer? _auth;
  bool isAuth(){
    if(Token==null)
      return false;
    return true;
  }
  String? get id =>_userId;

  String? get Token {
    if(_expiryDate!=null&&_expiryDate!.isAfter(DateTime.now())&&_token!="")return _token;
    return null;
}
  Future<void> signup(String email, String password) async {
    final url=Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCPKAUSUf4Ed9XFj61JCdsLvY72w1MEntw");
try{
  final response = await http.post(
    url,
    body: json.encode(
      {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    ),
  );

  print(response.body);
  final x=json.decode(response.body);
  if(x['error']!=null) {
    throw HttpsExcption(messge: json.decode(response.body)['error']['message']);
  }


}catch(e)
{
  rethrow;
}

  }
  Future<void> signin(String email, String password) async {
    final url=Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCPKAUSUf4Ed9XFj61JCdsLvY72w1MEntw");

    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final x=json.decode(response.body);
    _token=x['idToken'];
    _expiryDate=DateTime.now().add(Duration(seconds:int.parse(x['expiresIn'])));
    _userId=x['localId'];
    print("here");
    logoutTimer();
    var prefs= await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      },
    );
    prefs.setString('userdata', userData);
    notifyListeners();
  }
  Future<bool> trylogin()
  async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userdata')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userdata')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String?;
    _userId = extractedUserData['userId'] as String?;
    _expiryDate = expiryDate;
    notifyListeners();
    logoutTimer();
    return true;
  }
  void logout()
  {
    print(_expiryDate?.second);
    _expiryDate=null;
    _userId=null;
    _token=null;
    if(_auth!=null){
      _auth!.cancel();
      _auth=null;
    }
    notifyListeners();

  }
  void logoutTimer()
  {
    if(_auth!=null)
    {
      _auth!.cancel();
    }
    final time=_expiryDate?.second;
    print(time);
    _auth=Timer(Duration(seconds:time! ), logout);

  }
}
