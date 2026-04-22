import 'package:academix/const/const.dart';
import 'package:academix/pages/read_pdf.dart';
import 'package:flutter/material.dart';

import '../pages/number_system_conversion/conversion.dart';

class Tools extends StatelessWidget {
  const Tools({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ActionChip(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConversionPage()));
              },
              label: const Text(
                "Number Conversion",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ActionChip(
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ReadPdf()));
            },
            label: const Text(
              "Read Notes",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
