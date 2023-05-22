import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<Directory> getApplicationDocumentsDirectory() async {
  return Directory('C:\\Users\\naush\\OneDrive\\Desktop\\').create(recursive: true);
}
