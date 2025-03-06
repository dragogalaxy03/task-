import 'dart:convert';

class BeatPlanningResponse {
  final int type;
  final String msg;
  final List<UserData> data;

  BeatPlanningResponse({
    required this.type,
    required this.msg,
    required this.data,
  });

  factory BeatPlanningResponse.fromJson(Map<String, dynamic> json) {
    return BeatPlanningResponse(
      type: json['type'],
      msg: json['msg'],
      data: (json['data'] as List).map((e) => UserData.fromJson(e)).toList(),
    );
  }
}

class UserData {
  final User user;
  final Today today;
  final List<DayData> all;

  UserData({
    required this.user,
    required this.today,
    required this.all,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      today: Today.fromJson(json['today']),
      all: (json['all'] as List).map((e) => DayData.fromJson(e)).toList(),
    );
  }
}

class User {
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String designation;
  final String department;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      phone: json['phone'] ?? "",
      designation: json['designation'],
      department: json['department'],
    );
  }
}

class Today {
  final String dayName;
  final int total;
  final int visited;
  final int pending;
  final List<BeatPlanning> beatPlanning;

  Today({
    required this.dayName,
    required this.total,
    required this.visited,
    required this.pending,
    required this.beatPlanning,
  });

  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(
      dayName: json['day_name'],
      total: json['total'],
      visited: json['visited'],
      pending: json['pending'],
      beatPlanning: (json['beatplanning'] as List)
          .map((e) => BeatPlanning.fromJson(e))
          .toList(),
    );
  }
}

class BeatPlanning {
  final int id;
  final String locationName;
  final String? checkIn;
  final String? checkOut;
  final String? workingHours;

  BeatPlanning({
    required this.id,
    required this.locationName,
    this.checkIn,
    this.checkOut,
    this.workingHours,
  });

  factory BeatPlanning.fromJson(Map<String, dynamic> json) {
    return BeatPlanning(
      id: json['id'],
      locationName: json['location_name'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      workingHours: json['working_hours'],
    );
  }
}

class DayData {
  final String dayName;
  final int total;
  final int visited;
  final int pending;
  final List<BeatPlanning> locations;

  DayData({
    required this.dayName,
    required this.total,
    required this.visited,
    required this.pending,
    required this.locations,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      dayName: json['day_name'],
      total: json['total'],
      visited: json['visited'],
      pending: json['pending'],
      locations: (json['locations'] as List)
          .map((e) => BeatPlanning.fromJson(e))
          .toList(),
    );
  }
}

// Function to parse the JSON response
BeatPlanningResponse parseBeatPlanningResponse(String jsonStr) {
  final Map<String, dynamic> jsonData = json.decode(jsonStr);
  return BeatPlanningResponse.fromJson(jsonData);
}
