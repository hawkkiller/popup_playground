import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popup_playground/custom.dart';
import 'package:popup_playground/dropdown_button.dart';
import 'package:popup_playground/menu_anchor.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: _Body()),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = max((MediaQuery.of(context).size.width - 1024) / 2, 16.0);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          sliver: const SliverMainAxisGroup(
            slivers: [
              MenuAnchorShowcase(),
              SliverPadding(
                padding: EdgeInsets.only(top: 32),
              ),
              DropdownButtonShowcase(),
              SliverPadding(
                padding: EdgeInsets.only(top: 32),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 32),
              ),
              CustomPopupsShowcase(),
            ],
          ),
        ),
      ],
    );
  }
}
