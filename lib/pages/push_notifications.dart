//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';


class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  PushNotificationsScreenState createState() => PushNotificationsScreenState();
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Уведомления')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Назад на главную страницу '),
        ),
      ),
    );
  }
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