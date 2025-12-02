import 'dart:math';

import 'package:compressor_mobile/enums/pressure_type.dart';
import 'package:compressor_mobile/enums/temperature_type.dart';
import 'package:compressor_mobile/models/_models_lib.dart';
import 'package:compressor_mobile/services/_services_lib.dart';
import 'package:intl/intl.dart';

import '../widgets/_widgets_lib.dart';
import '../src/authentication/_authentication_lib.dart';
import '../view_models/_view_model_lib.dart';
import '../utils/_utils_lib.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_view.dart';
part 'login.dart';
part 'temperature_view.dart';
part 'pressure_view.dart';
part 'compressor_control.dart';
part 'about.dart';
part 'config_ip_view.dart';
part 'about_dispositive_view.dart';
part 'developer_profile_view.dart';
part 'hour_load_total_hours_view.dart';
part 'compressor_falhas_view.dart';
