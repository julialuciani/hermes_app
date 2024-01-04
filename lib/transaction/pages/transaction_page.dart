import 'package:flutter/material.dart';
import 'package:hermes_app/shared/utils/transaction_type_enum.dart';

class TransactionPage extends StatefulWidget {
  final TransactionTypeEnum transactionTypeEnum;

  const TransactionPage({
    Key? key,
    required this.transactionTypeEnum,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Page'),
      ),
      body: Container(),
    );
  }
}
