import 'package:uuid/uuid.dart';

class UserService {
  // generate unique user id
  static String getUniqueId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}