class Weather {
  Weather({
    this.location,
    this.current,
    this.forecast,
    this.alerts,
  });

  final Location? location;
  final Current? current;
  final Forecast? forecast;
  final Alerts? alerts;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      current: json["current"] == null ? null : Current.fromJson(json["current"]),
      forecast: json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]),
      alerts: json["alerts"] == null ? null : Alerts.fromJson(json["alerts"]),
    );
  }
}

class Alerts {
  Alerts({this.alert});
  final List<dynamic>? alert;

  factory Alerts.fromJson(Map<String, dynamic> json) {
    return Alerts(
      alert: json["alert"] == null ? [] : List<dynamic>.from(json["alert"].map((x) => x)),
    );
  }
}

class Current {
  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
    this.timeEpoch,
    this.time,
    this.snowCm,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
  });

  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final int? tempC;
  final double? tempF;
  final int? isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final int? windDegree;
  final String? windDir;
  final int? pressureMb;
  final double? pressureIn;
  final double? precipMm;
  final double? precipIn;
  final int? humidity;
  final int? cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final double? windchillC;
  final double? windchillF;
  final double? heatindexC;
  final double? heatindexF;
  final double? dewpointC;
  final double? dewpointF;
  final int? visKm;
  final int? visMiles;
  final double? uv;
  final double? gustMph;
  final double? gustKph;
  final Map<String, double>? airQuality;
  final int? timeEpoch;
  final String? time;
  final double? snowCm;
  final int? willItRain;
  final int? chanceOfRain;
  final int? willItSnow;
  final int? chanceOfSnow;

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json["last_updated_epoch"],
      lastUpdated: json["last_updated"],
      tempC: json["temp_c"]?.toDouble(),
      tempF: json["temp_f"]?.toDouble(),
      isDay: json["is_day"],
      condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
      windMph: json["wind_mph"]?.toDouble(),
      windKph: json["wind_kph"]?.toDouble(),
      windDegree: json["wind_degree"],
      windDir: json["wind_dir"],
      pressureMb: json["pressure_mb"],
      pressureIn: json["pressure_in"]?.toDouble(),
      precipMm: json["precip_mm"]?.toDouble(),
      precipIn: json["precip_in"]?.toDouble(),
      humidity: json["humidity"],
      cloud: json["cloud"],
      feelslikeC: json["feelslike_c"]?.toDouble(),
      feelslikeF: json["feelslike_f"]?.toDouble(),
      windchillC: json["windchill_c"]?.toDouble(),
      windchillF: json["windchill_f"]?.toDouble(),
      heatindexC: json["heatindex_c"]?.toDouble(),
      heatindexF: json["heatindex_f"]?.toDouble(),
      dewpointC: json["dewpoint_c"]?.toDouble(),
      dewpointF: json["dewpoint_f"]?.toDouble(),
      visKm: json["vis_km"],
      visMiles: json["vis_miles"],
      uv: json["uv"]?.toDouble(),
      gustMph: json["gust_mph"]?.toDouble(),
      gustKph: json["gust_kph"]?.toDouble(),
      airQuality: json["air_quality"] == null
          ? null
          : Map.from(json["air_quality"])
          .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      timeEpoch: json["time_epoch"],
      time: json["time"],
      snowCm: json["snow_cm"]?.toDouble(),
      willItRain: json["will_it_rain"],
      chanceOfRain: json["chance_of_rain"],
      willItSnow: json["will_it_snow"],
      chanceOfSnow: json["chance_of_snow"],
    );
  }
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String? text;
  final String? icon;
  final int? code;

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json["text"],
      icon: json["icon"],
      code: json["code"],
    );
  }
}

class Forecast {
  Forecast({
    required this.forecastday,
  });

  final List<Forecastday> forecastday;

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: json["forecastday"] == null
          ? []
          : List<Forecastday>.from(json["forecastday"]!.map((x) => Forecastday.fromJson(x))),
    );
  }
}

class Forecastday {
  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  final DateTime? date;
  final int? dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Current>? hour;

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      date: DateTime.tryParse(json["date"] ?? ""),
      dateEpoch: json["date_epoch"],
      day: json["day"] == null ? null : Day.fromJson(json["day"]),
      astro: json["astro"] == null ? null : Astro.fromJson(json["astro"]),
      hour: json["hour"] == null
          ? []
          : List<Current>.from(json["hour"].map((x) => Current.fromJson(x))),
    );
  }
}



class Astro {
  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final int? moonIllumination;
  final int? isMoonUp;
  final int? isSunUp;

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      moonrise: json["moonrise"],
      moonset: json["moonset"],
      moonPhase: json["moon_phase"],
      moonIllumination: json["moon_illumination"],
      isMoonUp: json["is_moon_up"],
      isSunUp: json["is_sun_up"],
    );
  }
}

class Day {
  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  final double? maxtempC;
  final double? maxtempF;
  final double? mintempC;
  final double? mintempF;
  final double? avgtempC;
  final double? avgtempF;
  final double? maxwindMph;
  final double? maxwindKph;
  final double? totalprecipMm;
  final double? totalprecipIn;
  final double? totalsnowCm;
  final int? avgvisKm;
  final int? avgvisMiles;
  final int? avghumidity;
  final int? dailyWillItRain;
  final int? dailyChanceOfRain;
  final int? dailyWillItSnow;
  final int? dailyChanceOfSnow;
  final Condition? condition;
  final double? uv;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json["maxtemp_c"]?.toDouble(),
      maxtempF: json["maxtemp_f"]?.toDouble(),
      mintempC: json["mintemp_c"]?.toDouble(),
      mintempF: json["mintemp_f"]?.toDouble(),
      avgtempC: json["avgtemp_c"]?.toDouble(),
      avgtempF: json["avgtemp_f"]?.toDouble(),
      maxwindMph: json["maxwind_mph"]?.toDouble(),
      maxwindKph: json["maxwind_kph"]?.toDouble(),
      totalprecipMm: json["totalprecip_mm"]?.toDouble(),
      totalprecipIn: json["totalprecip_in"]?.toDouble(),
      totalsnowCm: json["totalsnow_cm"]?.toDouble(),
      avgvisKm: json["avgvis_km"],
      avgvisMiles: json["avgvis_miles"],
      avghumidity: json["avghumidity"],
      dailyWillItRain: json["daily_will_it_rain"],
      dailyChanceOfRain: json["daily_chance_of_rain"],
      dailyWillItSnow: json["daily_will_it_snow"],
      dailyChanceOfSnow: json["daily_chance_of_snow"],
      condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
      uv: json["uv"]?.toDouble(),
    );
  }
}

class Location {
  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      region: json["region"],
      country: json["country"],
      lat: json["lat"]?.toDouble(),
      lon: json["lon"]?.toDouble(),
      tzId: json["tz_id"],
      localtimeEpoch: json["localtime_epoch"],
      localtime: json["localtime"],
    );
  }
}
