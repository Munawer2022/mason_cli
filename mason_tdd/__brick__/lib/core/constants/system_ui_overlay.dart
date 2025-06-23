import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setCustomSystemUIOverlayStyle() =>
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark));
