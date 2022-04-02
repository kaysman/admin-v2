import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class BankDetails extends StatelessWidget {
  final String? bankAccountNumber;
  final String? notes;
  const BankDetails({
    Key? key,
    this.bankAccountNumber,
    this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bank Details', style: Theme.of(context).textTheme.bodyText2),
        SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Details(
              title: 'Bank Account Number',
              value: '${bankAccountNumber ?? '-'}',
            ),
            SizedBox(
              height: 16,
            ),
            Details(
              title: 'Notes',
              value: '${notes ?? '-'}',
            ),
          ],
        )
      ],
    );
  }
}
