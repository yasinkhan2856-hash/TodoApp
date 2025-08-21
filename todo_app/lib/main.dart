import 'package:provider/provider.dart';
import 'package:todo_app/utils/libs.dart';
import 'login and sign up/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
}
