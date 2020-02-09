import 'package:flutter/foundation.dart';

class LoginBloc with ChangeNotifier{

  bool _isObscure  = true;

  bool get obscure => _isObscure;

  set obscure(bool newvalue){
    _isObscure = newvalue;
    notifyListeners();
  }

}