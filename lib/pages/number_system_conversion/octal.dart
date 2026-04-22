import 'package:academix/const/const.dart';
import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';

class Octal extends StatefulWidget {
  const Octal({super.key});

  @override
  State<Octal> createState() => _OctalState();
}

class _OctalState extends State<Octal> {
  String input = "";
  String result = "";
  // ignore: non_constant_identifier_names
  var numeral_systems = NumeralSystems();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    input = val;
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      hintText: "      Octal Number",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(18.0),
          sliver: SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                setState(() {
                  numeral_systems.convert(NUMERAL_SYSTEMS.octal, input);
                  result = numeral_systems.binary.stringValue.toString();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "Convert to Binary",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(18.0),
          sliver: SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                setState(() {
                  numeral_systems.convert(NUMERAL_SYSTEMS.octal, input);
                  result = numeral_systems.decimal.stringValue.toString();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "Convert to Decimal",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(18.0),
          sliver: SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                setState(() {
                  numeral_systems.convert(NUMERAL_SYSTEMS.octal, input);
                  result = numeral_systems.hexadecimal.stringValue.toString();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "Convert to HexaDecimal",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 18.0),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                // ignore: unnecessary_string_interpolations
                "$result",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
