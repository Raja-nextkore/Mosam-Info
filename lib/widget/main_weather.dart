import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({
    Key key,
    this.wData,
  }) : super(key: key);

  final TextStyle _style1 = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 5.0),
      height: MediaQuery.of(context).size.height / 3.2,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined),
              Text('${wData.weather.cityName}', style: _style1),
            ],
          ),
          const SizedBox(height: 5.0),
          Text(
            DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            style: _style2,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0, right: 25.0),
                child: MapString.mapStringToIcon(
                    '${wData.weather.currently}', context, 55.0),
              ),
              Text(
                '${wData.weather.temp.toStringAsFixed(0)}°C',
                style: const TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            '${wData.weather.tempMax.toStringAsFixed(0)}°/ ${wData.weather.tempMin.toStringAsFixed(0)}° Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
            style: _style1.copyWith(fontSize: 19.0),
          ),
          const SizedBox(height: 5),
          Text(
            toBeginningOfSentenceCase('${wData.weather.description}')
                .toString(),
            style: _style1.copyWith(fontSize: 19.0),
          ),
        ],
      ),
    );
  }
}
