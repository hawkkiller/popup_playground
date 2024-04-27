import 'dart:math';

import 'package:flutter/material.dart';
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
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: const FlutterLogo(),
                        applicationName: 'MenuAnchor Example',
                        applicationVersion: '1.0.0',
                        children: const [
                          Text('This is an example app for the MenuAnchor package.'),
                        ],
                      );
                    },
                  ),
                ],
                floating: true,
                pinned: true,
                snap: false,
              ),
              const MenuAnchorShowcase(),
            ],
          ),
        ),
      ],
    );
  }
}
