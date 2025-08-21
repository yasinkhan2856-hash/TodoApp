
class Weatherdata {
  Location location;
  Current current;
  Forecast forecast;
  AirQuality airQuality;
  Alerts alerts;

  Weatherdata({
    required this.location,
    required this.current,
    required this.forecast,
    required this.airQuality,
    required this.alerts,
  });

  factory Weatherdata.fromJson(Map<String, dynamic> json) {
    return Weatherdata(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
      airQuality: AirQuality.fromJson(json['current']['air_quality']),
      alerts: Alerts.fromJson(json['alerts']),
    );
  }
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double precipMm;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double visKm;
  double uv;
  double gustKph;
  AirQuality airQuality;

  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.precipMm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.uv,
    required this.gustKph,
    required this.airQuality,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      uv: json['uv'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
      airQuality: AirQuality.fromJson(json['air_quality']),
    );
  }
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

class Forecast {
  List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List;
    List<ForecastDay> forecastDays =
    list.map((i) => ForecastDay.fromJson(i)).toList();

    return Forecast(forecastday: forecastDays);
  }
}

class ForecastDay {
  String date;
  Day day;
  List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.day,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var hourList = json['hour'] as List;
    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
      hour: hourList.map((i) => Hour.fromJson(i)).toList(),
    );
  }
}

class Day {
  double maxtempC;
  double maxtempF;
  double mintempC;
  double mintempF;
  double avgtempC;
  double avgtempF;
  Condition condition;
  double avgHumidity;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.condition,
    required this.avgHumidity,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'].toDouble(),
      maxtempF: json['maxtemp_f'].toDouble(),
      mintempC: json['mintemp_c'].toDouble(),
      mintempF: json['mintemp_f'].toDouble(),
      avgtempC: json['avgtemp_c'].toDouble(),
      avgtempF: json['avgtemp_f'].toDouble(),
      condition: Condition.fromJson(json['condition']),
      avgHumidity: json['avghumidity'].toDouble(),
    );
  }
}

class Hour {
  String time;
  double tempC;
  double tempF;
  Condition condition;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double precipMm;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double visKm;
  double gustKph;
  double uv;

  Hour({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.precipMm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.gustKph,
    required this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      condition: Condition.fromJson(json['condition']),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
      uv: json['uv'].toDouble(),
    );
  }
}

class AirQuality {
  double co;
  double no2;
  double o3;
  double so2;
  double pm2_5;
  double pm10;
  double usEpaIndex;
  double gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: json['co'].toDouble(),
      no2: json['no2'].toDouble(),
      o3: json['o3'].toDouble(),
      so2: json['so2'].toDouble(),
      pm2_5: json['pm2_5'].toDouble(),
      pm10: json['pm10'].toDouble(),
      usEpaIndex: json['us-epa-index'].toDouble(),
      gbDefraIndex: json['gb-defra-index'].toDouble(),
    );
  }
}

class Alerts {
  List<Alert>? alertList;

  Alerts({this.alertList});

  factory Alerts.fromJson(Map<String, dynamic> json) {
    if (json['alert'] == null) {
      return Alerts(alertList: []);
    }
    var list = json['alert'] as List;
    List<Alert> alerts = list.map((i) => Alert.fromJson(i)).toList();
    return Alerts(alertList: alerts);
  }
}

class Alert {
  String headline;
  String severity;
  String urgency;
  String areas;
  String event;
  String note;
  String effective;
  String expires;

  Alert({
    required this.headline,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.event,
    required this.note,
    required this.effective,
    required this.expires,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      headline: json['headline'],
      severity: json['severity'],
      urgency: json['urgency'],
      areas: json['areas'],
      event: json['event'],
      note: json['note'],
      effective: json['effective'],
      expires: json['expires'],
    );
  }
}