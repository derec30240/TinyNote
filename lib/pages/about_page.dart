import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TinyNote is a simple note app.\nIt\'s built by Dr. Kee using Flutter.',
              style: TextStyle(
                fontSize: 24,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Github repository: TinyNote@derec30240',
              style: TextStyle(
                fontSize: 24,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.0),
            Text(
              'Copyright (c) 2024 by Dr. Kee. All rights reserved.',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
