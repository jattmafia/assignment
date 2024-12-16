import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  EdgeInsets get kdefaultPadding => const EdgeInsets.all(15);

  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => theme.colorScheme;
  TextTheme get style => theme.textTheme;

  void error(dynamic e) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: scheme.onErrorContainer,
        behavior: SnackBarBehavior.floating,
        content: Text(
          '$e',
          style: TextStyle(color: scheme.errorContainer),
        ),
      ),
    );
  }

  void success(dynamic e) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Text(
        '$e',
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

 


}
extension DateStringFormatter on String {
 
  String toFormattedDate() {
    try {
      final dateTime = DateTime.parse(this); 
      return dateTime.toIso8601String().split('T')[0]; 
    } catch (e) {
      throw FormatException(
          "Invalid date format. Expected format: 'YYYY-MM-DDTHH:mm:ss.sss'.");
    }
  }
}