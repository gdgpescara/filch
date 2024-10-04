import 'package:flutter/material.dart';

enum ShiftLocationsEnum {
  checkIn(Color(0xFF335171), 'Check in'),
  coffee(Color(0xFF4F3B2D), 'Coffee'),
  lunch(Color(0xFF622C69), 'Lunch'),
  communityDinner(Color(0xFF622C69), 'Community dinner'),
  wardrobe(Color(0xFF573646), 'Wardrobe'),
  taxi(Color(0xFF575336), 'Taxi'),
  coordination(Color(0xFF713737), 'Coordination'),
  masterOfCeremony(Color(0xFF286769), 'MoC'),
  masterOfCeremonyAssistant(Color(0xFF2C6944), 'MoC assistant');

  const ShiftLocationsEnum(this.color, this.label);
  final Color color;
  final String label;
}
