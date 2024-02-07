class IslamicCalendar {
  int? code;
  String? status;
  List<Data>? data;

  IslamicCalendar({this.code, this.status, this.data});

  IslamicCalendar.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Gregorian? gregorian;
  Hijri? hijri;

  Data({this.gregorian, this.hijri});

  Data.fromJson(Map<String, dynamic> json) {
    gregorian = json['gregorian'] != null
        ? new Gregorian.fromJson(json['gregorian'])
        : null;
    hijri = json['hijri'] != null ? new Hijri.fromJson(json['hijri']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gregorian != null) {
      data['gregorian'] = this.gregorian!.toJson();
    }
    if (this.hijri != null) {
      data['hijri'] = this.hijri!.toJson();
    }
    return data;
  }
}

class Gregorian {
  String? date;

  Gregorian({this.date});

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}

class Hijri {
  String? date;
  String? format;
  String? day;
  List<String>? holidays;

  Hijri({this.date, this.format, this.day, this.holidays});

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    holidays = json['holidays'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['format'] = this.format;
    data['day'] = this.day;
    data['holidays'] = this.holidays;
    return data;
  }
}
