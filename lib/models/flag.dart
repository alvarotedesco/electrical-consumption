// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FlagModel {
  String name;
  Icon icon;
  int id;

  FlagModel({
    required this.icon,
    required this.name,
    required this.id,
  });
}
