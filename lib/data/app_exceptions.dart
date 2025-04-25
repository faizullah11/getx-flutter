

class AppExceptions implements Exception {

  final _message ;
  final _prefix ;
  AppExceptions([this._message , this._prefix]);

  @override
  String toString(){
    return '$_prefix$_message' ;
  }

}

class FetchDataException extends AppExceptions {

  FetchDataException([String? message]) : super(message, 'Error :::: \n');
}


class BadRequestException extends AppExceptions {

  BadRequestException([String? message]) : super(message, 'Invalid request\n');
}


class UnauthorisedException extends AppExceptions {

  UnauthorisedException([String? message]) : super(message, 'Unauthorised request\n');
}


class InvalidInputException extends AppExceptions {

  InvalidInputException([String? message]) : super(message, 'Invalid Input\n');
}

class TimeOutException extends AppExceptions {

  TimeOutException([String? message]) : super(message, 'Request Timeout, Try again.\n');
}