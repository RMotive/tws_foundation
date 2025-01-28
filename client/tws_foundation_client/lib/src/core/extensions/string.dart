extension StringExtension on String{

  /// Validate if a decimal value pass the number length paramaters.
  /// Returns TRUE when the double value is valid, else, return FALSE.
  bool evaluateAsDecimal({int maxIntegers = 4, int maxDecimals = 6}){
    //skip default values.
    if(this == "0" || this == "0.0") return true;
    double? parsedValue = double.tryParse(this);
    //validate if the text input actually is a decimal value.
    if(parsedValue == null) return false;

    List<String> parts = split('.');
    int integers = parts[0].length;
    int decimals = parts.length > 1? parts[1].length : 0;

    if(decimals > maxDecimals) return false;
    if(integers > maxIntegers) return false;

    return true;
  }
}