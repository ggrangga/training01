class ValidationMixin {
  String validateLogin(String value) {
    if(value.length < 5)          
      return "";

    return null;
  }
}