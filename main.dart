import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDayMode = true;
  bool isSmallText = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDayMode = prefs.getBool('isDayMode') ?? true;
      isSmallText = prefs.getBool('isSmallText') ?? true;
    });
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDayMode', isDayMode);
    prefs.setBool('isSmallText', isSmallText);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Shared Preferences'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dia'),
                Switch(
                  value: !isDayMode, 
                  onChanged: (value) {
                    setState(() {
                      isDayMode = !value;
                      saveSettings();
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pequena'),
                Switch(
                  value: isSmallText,
                  onChanged: (value) {
                    setState(() {
                      isSmallText = value;
                      saveSettings();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: 200.0,
              height: 100.0,
              alignment: Alignment.center,
              color: isDayMode
                  ? Colors.grey[800]
                  : Colors.white,
              child: Text(
                'Aula 08 - Shared Preferences',
                style: TextStyle(
                  fontSize: isSmallText ? 16.0 : 24.0,
                  color: isDayMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
