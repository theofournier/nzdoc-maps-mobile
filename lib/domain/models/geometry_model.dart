class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}

sealed class LineGeometry {}

class LineString extends LineGeometry {
  final List<Point> coordinates;

  LineString({required this.coordinates});
}

class MultiLineString extends LineGeometry {
  final List<List<Point>> coordinates;

  MultiLineString({required this.coordinates});
}
