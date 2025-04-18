import 'package:flutter/material.dart';

class ProjectData {
  final String title;
  final String address;
  final DateTime date;
  final String status;
  final List<String> assignee;
  final String priority;
  final int percentage;

  ProjectData({
    required this.title,
    required this.address,
    required this.date,
    required this.status,
    required this.assignee,
    required this.priority,
    required this.percentage
  });
}