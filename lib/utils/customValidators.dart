import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';

class CustomValidators {
  static FormFieldValidator<dynamic> numeric<String>(
      BuildContext context, {String errorText}){
    return (val) {
      return null == num.tryParse(val) ? FormBuilderLocalizations.of(context).numericErrorText : null;
    };
  }
}