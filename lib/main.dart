import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popup_playground/custom_popups.dart';
import 'package:popup_playground/dropdown_button.dart';
import 'package:popup_playground/menu_anchor.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MainApp());
}

final lightTheme = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue));

final darkTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: _Body()),
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
        SliverAppBar(
          title: const Text('Popup Playground'),
          pinned: true,
          actions: [
            IconButton(
              onPressed: () => launchUrlString('https://github.com/hawkkiller/popup_playground'),
              icon: const Icon(Icons.code),
              tooltip: 'Source code',
            ),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          sliver: const SliverMainAxisGroup(
            slivers: [
              CustomPopupsShowcase(),
              SliverPadding(padding: EdgeInsets.only(top: 32)),
              MenuAnchorShowcase(),
              SliverPadding(padding: EdgeInsets.only(top: 32)),
              DropdownButtonShowcase(),
              SliverPadding(padding: EdgeInsets.only(top: 32)),
              SliverPadding(padding: EdgeInsets.only(top: 32)),
            ],
          ),
        ),
      ],
    );
  }
}
