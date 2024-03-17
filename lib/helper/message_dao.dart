
import 'package:firebase_database/firebase_database.dart';

class MessageDao {
  static final DatabaseReference messagesRef = FirebaseDatabase.instance.ref();
}

