import 'package:lets_connect/utils/translation_service.dart';

class Validator{
  static String? email(String? value){
    if(value?.trim().isEmpty ?? true){
      return translationService.text("key_email_required");
    }
    else if((value?.trim().length ?? 0) > 256){
      return translationService.text("key_email_length_validation");
    }
    else if(RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
      ).hasMatch(value!)){
      return null;
    }
    return translationService.text("key_please_enter_valid_email");
  }

  static String? password(String? value){
    if(value?.trim().isEmpty ?? true){
      return translationService.text("key_password_required");
    }
    else if(value!.length < 8){
      return translationService.text("key_please_enter_valid_password");
    }
    return null;
  }
  static String? createPassword(String? value){
    String validatorStr = '';
    if(value?.trim().isEmpty ?? true){
      return translationService.text("key_password_required");
    }
    if(value!.length < 8){
      validatorStr += '\n${translationService.text("key_atleast_8_character")!}';
    }
    if(!value.contains(RegExp(r'\d'), 0)){
      validatorStr += '\n${translationService.text("key_atleast_number")!}';
    }
    if(!value.contains(RegExp(r'[A-Z]'), 0)){
      validatorStr += '\n${translationService.text("key_atleast_upper_case_character")!}';
    }
    if(value.contains(RegExp(r'^[\w&.-]+$'), 0)){
      validatorStr += '\n${translationService.text("key_atleast_special_character")!}';
    }
    if(validatorStr.trim().isNotEmpty){
      return translationService.text("key_password_must_contain")! + validatorStr;
    }
    return null;
  }
}