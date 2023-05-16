import 'package:flutter/material.dart';
import 'package:learning_words/pages/flashcards.dart';
import 'package:learning_words/pages/mysignin.dart';
import 'package:learning_words/pages/push_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning_words/pages/translation.dart';
//import 'package:myapp/firebase_options.dart';

//очки пользователя
int retScore = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leralingo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  MyHomePage(collectionPath: '', usermapdata: {},),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.collectionPath,
    required this.usermapdata,
  }) : super(key: key);
  final String collectionPath;
  final Map<String, dynamic> usermapdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная страница')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlashcardsScreen()),
                );
              },
              child: const Text('Карточки'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: const Text('Вход'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PushNotificationsScreen()),
                );
              },
              child: const Text('Уведомления'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TranslationPage()),
                );
              },
              child: const Text('Учить слова!'),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leralingo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PushNotificationsScreen(),
    );
  }
}


class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  PushNotificationsScreenState createState() => PushNotificationsScreenState();
}

class PushNotificationsScreenState extends State<PushNotificationsScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectNotificationSubject
          .add(payload.payload.toString()); /////////////////////////////
    });
  }

  Future<void> _onScheduleNotificationButtonPressed() async {
    var scheduledTime = DateTime.now().add(Duration(seconds: 5));

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id', 'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(presentAlert: true, presentBadge: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      1, // Идентификатор уведомления
      'Пуш-уведомление', // Заголовок уведомления
      'Это текст пуш-уведомления', // Текст уведомления
      scheduledTime, // Время планирования уведомления
      platformChannelSpecifics,
      payload:
          'scheduled_notification', // Дополнительные данные, передаваемые с уведомлением
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Уведомление запланировано'),
          content:
              const Text('Уведомление будет отправлено в выбранное время.'),
          actions: [
            TextButton(
              child: const Text('ОК'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onCancelNotificationButtonPressed() async {
    await flutterLocalNotificationsPlugin.cancel(1);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Уведомление отменено'),
          content: Text('Запланированное уведомление было отменено.'),
          actions: [
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leralingo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _onScheduleNotificationButtonPressed,
              child: Text('Запланировать уведомление'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onCancelNotificationButtonPressed,
              child: Text('Отменить уведомление'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
