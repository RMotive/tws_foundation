import 'package:flutter/services.dart';

/// {formatter} class.
/// 
/// Implements a [TextInputFormatter] to limit the input of coordinate values
/// to a maximum of 3 integer digits and 6 decimal digits.
class CoordenatesPrecisionFormtter extends TextInputFormatter {
  static const int maxDigits = 9;
  static const int maxIntegerDigits = 3;
  static const int maxDecimalDigits = 6;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String raw = newValue.text;

    bool isNegative = raw.startsWith('-');
    raw = raw.replaceAll(RegExp(r'[^0-9]'), '');

    if (raw.length > maxDigits) {
      raw = raw.substring(0, maxDigits);
    }

    String integerPart = raw.length <= maxIntegerDigits
        ? raw
        : raw.substring(0, maxIntegerDigits);

    String decimalPart = raw.length > maxIntegerDigits
        ? raw.substring(maxIntegerDigits)
        : '';

    if (decimalPart.length > maxDecimalDigits) {
      decimalPart = decimalPart.substring(0, maxDecimalDigits);
    }

    String formatted = decimalPart.isEmpty
        ? integerPart
        : '$integerPart.$decimalPart';

    if (isNegative) {
      formatted = '-$formatted';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

}