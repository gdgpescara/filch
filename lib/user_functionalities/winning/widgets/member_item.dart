import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/models/house_member.dart';
import '../../../common_functionalities/widgets/app_card.dart';

class MemberItem extends StatelessWidget {
  const MemberItem(this.member, {super.key, required this.position});

  final HouseMember member;
  final int position;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: _borderByPosition,
      child: SizedBox(
        height: max(100 - (position * 10).toDouble(), 60),
        child: position < 4 ? _podium(context) : _others(context),
      ),
    );
  }

  Widget _podium(BuildContext context) {
    return Column(
      children: [
        _points(context),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              _avatar(),
              const SizedBox(width: 8),
              Expanded(
                child: _name(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _others(BuildContext context) {
    return Row(
      children: [
        _avatar(),
        const SizedBox(width: 8),
        Expanded(
          child: _name(context),
        ),
        const SizedBox(width: 16),
        _points(context),
      ],
    );
  }

  Text _name(BuildContext context) =>
      Text(member.displayName ?? member.email, style: Theme.of(context).textTheme.titleMedium);

  CircleAvatar _avatar() {
    return CircleAvatar(
      radius: 20,
      backgroundImage: member.photoURL != null ? NetworkImage(member.photoURL ?? '') : null,
    );
  }

  Text _points(BuildContext context) {
    return Text(
      '${member.points ?? 0} pt',
      style: GoogleFonts.jetBrainsMono(fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
    );
  }

  Color get _borderByPosition {
    switch (position) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.transparent;
    }
  }
}
