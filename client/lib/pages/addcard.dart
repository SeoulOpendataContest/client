import "package:flutter/material.dart";
// import 'package:credit_card_scanner/credit_card_scanner.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  @override
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  bool isCard = false;
  @override
  Widget build(BuildContext context) {
    var cardDetails;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const SizedBox(),
            shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
            title: const Text(
              '카드 정보',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10),
            ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  setState(() {
                    // cardDetails = CardScanner.scanCard(
                    //   scanOptions: const CardScanOptions(
                    //     scanCardHolderName: true,
                    //   ),
                    // );
                  });
                  print(cardDetails);
                },
                child: const Text('scan card'),
              ),
              if (cardDetails != null)
                Text('Card Number: ${cardDetails!.cardNumber}'),
            ],
          ),
        ));
  }
}
