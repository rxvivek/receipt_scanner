import 'dart:math';

class Polygon {
  final List<Point<num>>? points;
  String? name;
  // double version;
  ///Create a `Polygon` with vertices at `points`.
  /// Pass a `List<Point<num>>`
  Polygon(List<Point<num>> points) : points = points.toList(growable: false) {
    var _number_of_point = this.points!.length;
    if (_number_of_point < 3) {
      throw NeedsAtLeastThreePoints(_number_of_point);
      //  throw new ArgumentError("Please provide three or more points.");
    }
//    name = tname;
  }

  /// returns `true` if `(x,y)` is present inside `Polygon`
  bool contains(num px, num py) {
    num ax = 0;
    num ay = 0;
    num bx = points![points!.length - 1].x - px;
    num by = points![points!.length - 1].y - py;
    int depth = 0;

    for (int i = 0; i < points!.length; i++) {
      ax = bx;
      ay = by;
      bx = points![i].x - px;
      by = points![i].y - py;

      if (ay < 0 && by < 0) continue; // both "up" or both "down"
      if (ay > 0 && by > 0) continue; // both "up" or both "down"
      if (ax < 0 && bx < 0) continue; // both points on left

      num lx = ax - ay * (bx - ax) / (by - ay);

      if (lx == 0) return true; // point on edge
      if (lx > 0) depth++;
    }

    return (depth & 1) == 1;
  }

}

class NeedsAtLeastThreePoints implements Exception {
  int _number_of_point;
  NeedsAtLeastThreePoints(this._number_of_point);
  String toString() =>
      "Please provide three or more points. Current number of Points: $_number_of_point";
  int currentPointsInPolygon() => this._number_of_point;
}

List<Point<num>> toListOfPoint(List<List<num>> list_of_list) {
  List<Point<num>> _out_list_of_point = [];
  list_of_list.forEach((_element_in_list_of_list) {
    _out_list_of_point.add(toPoint(_element_in_list_of_list));
  });
  return _out_list_of_point;
}

/// `List<num>` to `Point`
Point toPoint(List<num> list_of_xy) {
  int _length_of_list_xy = list_of_xy.length;
  if (_length_of_list_xy == 2) {
    return Point(list_of_xy[0], list_of_xy[1]);
  } else {
    throw WrongSizeForPoint(_length_of_list_xy);
  }
//    return Point(x,y);
}

///* `WrongSizeForPoint` is thrown if `to_Point()` has more or less than 2 element. Point has only x and y.
class WrongSizeForPoint implements Exception {
  int _length_of_list;
  WrongSizeForPoint(this._length_of_list);
  String toString() =>
      "Wrong size, List must have 2 element. Current Size: $_length_of_list";
  int inputListLength() => this._length_of_list;
}

/// `List<List (x,y)>` to `Polygon`
Polygon toPolyFromListOfList(List<List<num>> list_of_list) {
  var _length_of_poly = list_of_list.length;
  if (_length_of_poly < 3) {
    throw NeedsAtLeastThreePoints(_length_of_poly);
  }
  List<Point<num>> _list_of_point = [];
  list_of_list.forEach((_element_in_list_of_list) {
    _list_of_point.add(toPoint(_element_in_list_of_list));
  });
  // debug-print
  // print(_list_of_point);
  return Polygon(_list_of_point);
}