import 'package:example/firebase/const.dart';

extension FirebaseStringX on String {
  String get cutName => length <= maxEventKeyLength ? this : substring(0, maxEventKeyLength);
  String get cutValue => length <= maxEventValueLength ? this : substring(0, maxEventValueLength);
}
