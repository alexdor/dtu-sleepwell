class ApiResponse {
  final String timestamp;
  final double humidity;
  final double temp;

  factory ApiResponse.fromJSON(Map<String, dynamic> f) {
    return new ApiResponse(
      humidity: f['humidity'].toDouble(),
      temp: f['temp'].toDouble(),
      timestamp: f['timestamp'],
    );
  }

  ApiResponse({this.timestamp, this.humidity, this.temp});
}
