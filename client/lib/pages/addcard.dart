import "package:flutter/material.dart";
import 'package:credit_card_scanner/credit_card_scanner.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  @override
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  bool isCard = false;
  CardDetails? _cardDetails;

  CardScanOptions scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    // enableDebugLogs: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );

  Future<void> scanCard() async {
    final CardDetails? cardDetails =
        await CardScanner.scanCard(scanOptions: scanOptions);
    if (!mounted || cardDetails == null) return;
    setState(() {
      _cardDetails = cardDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  await scanCard();
                },
                child: const Text('scan card'),
              ),
              _cardDetails == null
                  ? const Text('No card details found')
                  : Column(
                      children: [
                        Text('${_cardDetails}'),
                        Text('Card Number: ${_cardDetails?.cardNumber}'),
                        Text(
                            'Card Holder Name: ${_cardDetails?.cardHolderName}'),
                        Text('Card Expiry Date: ${_cardDetails?.expiryDate}'),
                      ],
                    ),
            ],
          ),
        ));
  }
}
