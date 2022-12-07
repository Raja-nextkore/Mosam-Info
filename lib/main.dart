import 'package:flutter/material.dart';
import 'package:mosam_info/provider/weather_provider.dart';
import 'package:mosam_info/screens/hourly_weather_screen.dart';
import 'package:mosam_info/screens/weekly_weather_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MosamInfo());
}

class MosamInfo extends StatelessWidget {
  const MosamInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.white,
          ),
        ),
        home: const HomeScreen(),
        routes: {
          WeeklyWeatherScreen.routeName: (context) =>
              const WeeklyWeatherScreen(),
          HourlyWeatherScreen.routeName: (context) =>
              const HourlyWeatherScreen(),
        },
      ),
    );
  }
}
