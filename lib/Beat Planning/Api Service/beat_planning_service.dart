import 'dart:convert';
import 'package:http/http.dart' as http;

class BeatPlanningService {
  static const String _baseUrl =
      "https://control.locowiz.com/public/api/timetracker/v1/beatplanning";
  static const String _deviceId = "TP1A.220624.014";
  static const String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiY2ZiZmY4MjQ5NTBhNjBhM2FhMzUzNmViODU5YzBkMmViMGM5MDY2NDAyZDRmODliZmUxZGQyNGM5YWMxYmU2NTMxNTI0ZmFjZWJjYTUzNzUiLCJpYXQiOjE3NDEyNTQzMjEsIm5iZiI6MTc0MTI1NDMyMSwiZXhwIjoxNzcyNzkwMzIxLCJzdWIiOiIxMjM5NSIsInNjb3BlcyI6W119.XIYnNHN7AmUWOGraJ-OycjjVt5apk3gMXtvwjhuhW4vA7HdjAlh9kv-h1fwWBOCISo3LA5Nb6jEgz4kn-tq4ce3mL-rD5HEwk5aRopNnz0c611LOHpmV5ukd5z6fPctCi0fc5vxG7_JVxVRFvIufNpCJUj6_h08FG73RHL4JTN2mV9lenk3WrTfLFhiLArBt8R3_rioFanBFJ3LDyBhjLpGd0oy8uWOsJrx9hKEP3LNuJrL69wqqpvoOiypeHfnHHyCyLK8RRy-IU8uweA8VI_AJr-HBa4-taeCvAh0SFkCY2VkfslwWtbZFHNygF5NuamQPKqZ4yQlfv2DvUAxNHHnZ0TtH_jNqKy6kSaurOznYxypw2fORfvZqa9tpE_coM9A6g0cpSCsvI3FET5_TFpevTOiRpvlxltx-4pX5JD51JLILieRRyI__6pGfJgbOCokshgvCQd9zZcrBwbN1Apcwx1oQo9ZWXfwaRHBL2EDUJtnjkM3dJoM90iCvXZFThgCVztvhmRuD99NFKqkigodsfyM3EH0GkgHMo8PSLhqAiUC0-gWM0vsB2l400CoWnk80tFpsq5-3J_eBQe8Xs12q3EzAVaHfizY9FiXIJgp8SYWX6B5MqF4KlvSG8ZUjkapYb6qqXb1nCg4CFrR0L0c3IpeeQxdRQDnAWj5c2rs";

  /// Fetches beat planning data from the API
  static Future<Map<String, dynamic>> fetchBeatPlanning() async {
    final Uri url = Uri.parse("$_baseUrl?device_id=$_deviceId");

    final headers = {
      "Authorization": "Bearer $_token",
      "Content-Type": "application/json",
    };

    // print("🔹 [API Request] GET $url");
    // print("🔹 [Headers] $headers");

    try {
      final response = await http.get(url, headers: headers);

      print("✅ [Response Code] ${response.statusCode}");
      print("✅ [Response Body] ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("⚠️ Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      print("❌ [Error] $error");
      throw Exception("Error fetching beat planning data: $error");
    }
  }
}
