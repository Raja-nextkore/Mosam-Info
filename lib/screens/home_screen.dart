import 'package:flutter/material.dart';
import 'package:mosam_info/widget/fade_in.dart';
import 'package:mosam_info/widget/weather_info.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weather_provider.dart';
import '../widget/hourly_forecast.dart';
import '../widget/location_error.dart';
import '../widget/main_weather.dart';
import '../widget/request_error.dart';
import '../widget/search_bar.dart';
import '../widget/seven_day_forecast.dart';
import '../widget/weather_details.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool _isLoading;

  @override
  initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refereshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: myContext.primaryColor,
                ),
              )
            : weatherData.loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: myContext.primaryColor,
                    ),
                  )
                : weatherData.isLocationError
                    ? const LocationError()
                    : Column(
                        children: [
                          const SearchBar(),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: ExpandingDotsEffect(
                              activeDotColor: myContext.primaryColor,
                              dotHeight: 6.0,
                              dotWidth: 6.0,
                            ),
                          ),
                          weatherData.isRequestError
                              ? const RequestError()
                              : Expanded(
                                  child: PageView(
                                    controller: _pageController,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        width: mediaQuery.size.width,
                                        child: RefreshIndicator(
                                          onRefresh: () =>
                                              _refereshData(context),
                                          backgroundColor: Colors.blue,
                                          child: ListView(
                                            children: [
                                              FadeIn(
                                                delay: 0,
                                                child: MainWeather(
                                                  wData: weatherData,
                                                ),
                                              ),
                                              FadeIn(
                                                delay: 0.33,
                                                child: WeatherInfo(
                                                  wData: weatherData
                                                      .currentWeather,
                                                ),
                                              ),
                                              FadeIn(
                                                delay: 0.66,
                                                child: HourlyForecast(
                                                  hourlyForecast:
                                                      weatherData.hourlyWeather,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.height,
                                        width: mediaQuery.size.width,
                                        child: ListView(
                                          children: [
                                            FadeIn(
                                              delay: 0.33,
                                              child: SevenDayForecast(
                                                wData: weatherData,
                                                dWeather:
                                                    weatherData.sevenDayWeather,
                                              ),
                                            ),
                                            FadeIn(
                                              delay: 0.66,
                                              child: WeatherDetail(
                                                  wData: weatherData),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
      ),
    );
  }
}
