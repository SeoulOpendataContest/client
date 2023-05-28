import 'package:flutter/material.dart';

class KindStorePage extends StatefulWidget {
  const KindStorePage({super.key});
  @override
  KindStorePageState createState() => KindStorePageState();
}

class KindStorePageState extends State<KindStorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        child: Center(
          child: Text('kind store'),
        ),
      ),
    );
  }
}
