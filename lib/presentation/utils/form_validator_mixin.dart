mixin FormValidatorMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateEmailAddress(String email) {
    if (email == null) {
      return false;
    }

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool validatePhoneNumber(String number) {
    if (number == null) {
      return false;
    }

    return RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(number);
  }

  bool isNotNull(Object obj) => obj != null;
}
