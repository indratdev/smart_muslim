import 'package:flutter/material.dart';
import 'package:smart_muslim/screens/homepage/home_page.dart';

class Routes {
  Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      '/': (_) => HomePage(),
    };
  }
}
