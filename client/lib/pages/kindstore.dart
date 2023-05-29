import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KindStorePage extends StatefulWidget {
  const KindStorePage({super.key});
  @override
  KindStorePageState createState() => KindStorePageState();
}

class KindStorePageState extends State<KindStorePage> {
  @override
  Widget build(BuildContext context) {
    AuthRepository.initialize(appKey: '1e890a87547af4d8f1032a5697419319');
    return Scaffold(body: KakaoMap());
  }
}
