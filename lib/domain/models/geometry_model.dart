class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}

class LineString {
  final List<Point> coordinates;

  LineString({required this.coordinates});
}

class MultiLineString {
  final List<List<Point>> coordinates;

  MultiLineString({required this.coordinates});
}
