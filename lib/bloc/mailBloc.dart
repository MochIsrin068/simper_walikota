import 'package:flutter/foundation.dart';

// ADD DISPOSISSI
class AddDispositionBloc with ChangeNotifier{

  String _value = "";

  String get value => _value;

  set value(String newValue){
    _value = newValue;
    notifyListeners();
  }

}


// ADD MAIL IN
class AddMailInBloc with ChangeNotifier{

  String _value = "";

  String get value => _value;

  set value(String newValue){
    _value = newValue;
    notifyListeners();
  }

}

// CHANGE COMMAND DISPOSITION
class ChangeCommandDisposistion with ChangeNotifier{

  String _value = "Hadiri dan Laporkan";

  String get value => _value;

  set value(String newValue){
    _value = newValue;
    notifyListeners();
  }
}

// DETAIL MAIL BLOC
class DetailMailBloc with ChangeNotifier{

  bool _pdfPage = true;

  bool get pdfPage => _pdfPage;

  set pdfPage(bool newState){
    _pdfPage = newState;
    notifyListeners();
  }
}

// DETAIL MAIL DISPOSITION BLOC
class DetailMailDisposisiBloc with ChangeNotifier{

  bool _pdfPage = true;

  bool get pdfPage => _pdfPage;

  set pdfPage(bool newState){
    _pdfPage = newState;
    notifyListeners();
  }
}

// DETAIL MAIN IN DISPOSISI
class CheckPDF with ChangeNotifier{

  bool _pdfPage = true;

  bool get pdfPage => _pdfPage;

  set pdfPage(bool newState){
    _pdfPage = newState;
    notifyListeners();
  }
}