import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class EditService {
  Future<List<ParseObject>> queryEdits(List<int> books);
}