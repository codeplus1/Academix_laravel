import 'package:academix/const/const.dart';
import 'package:flutter/material.dart';
import 'package:units_converter/properties/numeral_systems.dart';

class ConversionPage extends StatefulWidget {
  const ConversionPage({super.key});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  String input = "";
  String result = "";
  String selectedSourceSystem = "Binary";
  String selectedTargetSystem = "Binary";
  List<String> conversionSteps = []; // To store conversion steps

  final List<String> numeralSystems = [
    "Binary",
    "Decimal",
    "Octal",
    "Hexadecimal",
  ];

  // ignore: non_constant_identifier_names
  var numeral_systems = NumeralSystems();

  void convert() {
    conversionSteps.clear(); // Clear previous steps

    // Check if the input is empty
    if (input.isEmpty) {
      _showErrorDialog("Please enter a number before converting.");
      return; // Stop conversion if input is empty
    }

    // Record the initial input
    conversionSteps.add(
        "Converting $input from $selectedSourceSystem to $selectedTargetSystem");

    // Perform conversion based on selected source and target systems
    switch (selectedSourceSystem) {
      case "Binary":
        conversionSteps.add("Interpreting input as Binary");
        numeral_systems.convert(NUMERAL_SYSTEMS.binary, input);
        break;
      case "Decimal":
        conversionSteps.add("Interpreting input as Decimal");
        numeral_systems.convert(NUMERAL_SYSTEMS.decimal, input);
        break;
      case "Octal":
        conversionSteps.add("Interpreting input as Octal");
        numeral_systems.convert(NUMERAL_SYSTEMS.octal, input);
        break;
      case "Hexadecimal":
        conversionSteps.add("Interpreting input as Hexadecimal");
        numeral_systems.convert(NUMERAL_SYSTEMS.hexadecimal, input);
        break;
    }

    // Show conversion result steps
    switch (selectedTargetSystem) {
      case "Binary":
        result = numeral_systems.binary.stringValue.toString();
        conversionSteps.add("Converted to Binary: $result");
        break;
      case "Decimal":
        result = numeral_systems.decimal.stringValue.toString();
        conversionSteps.add("Converted to Decimal: $result");
        break;
      case "Octal":
        result = numeral_systems.octal.stringValue.toString();
        conversionSteps.add("Converted to Octal: $result");
        break;
      case "Hexadecimal":
        result = numeral_systems.hexadecimal.stringValue.toString();
        conversionSteps.add("Converted to Hexadecimal: $result");
        break;
    }

    setState(() {}); // Refresh the UI
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              primaryColor, // Set the background color to primaryColor
          title: Text(
            "Error",
            style: TextStyle(color: Colors.white), // Title color to match theme
          ),
          content: Text(
            message,
            style: TextStyle(
                color: Colors.white), // Message text color to match theme
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                    color: Colors.white), // Button text color to match theme
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showExplanation() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Conversion Explanation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: conversionSteps.map((step) {
                return Text(step);
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine keyboard type based on target system selection
    TextInputType keyboardType = (selectedSourceSystem == "Hexadecimal" ||
            selectedTargetSystem == "Hexadecimal")
        ? TextInputType.text
        : TextInputType.number;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        title: Text(
          "Number System",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement navigation to Learn page if needed
            },
            child: Text(
              "LEARN",
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                onChanged: (val) {
                  input = val;
                },
                keyboardType:
                    keyboardType, // Change keyboard type based on selection
                decoration: InputDecoration(
                  hoverColor: primaryColor,
                  focusColor: primaryColor,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText:
                      "Enter $selectedSourceSystem Number", // Dynamic hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Right side Selection Box
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdownButton(selectedSourceSystem,
                      (String? newValue) {
                    setState(() {
                      selectedSourceSystem = newValue!;
                    });
                  }),
                  Text("→", style: TextStyle(fontSize: 25)),
                  _buildDropdownButton(selectedTargetSystem,
                      (String? newValue) {
                    setState(() {
                      selectedTargetSystem = newValue!;
                    });
                  }),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    convert();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Set button color to red
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "CONVERT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18), // Set text color to white
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Result: $result",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              // Show explanation button only if there are conversion steps
              if (conversionSteps.isNotEmpty)
                ElevatedButton(
                  onPressed: showExplanation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Set button color to red
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "SHOW EXPLANATION",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18), // Set text color to white
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a styled dropdown button
  Widget _buildDropdownButton(String value, ValueChanged<String?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          DropdownButton<String>(
            value: value,
            underline: SizedBox(), // Remove the underline
            items: numeralSystems.map((String system) {
              return DropdownMenuItem<String>(
                value: system,
                child: Text(system),
              );
            }).toList(),
            onChanged: onChanged,
            icon: Icon(Icons.arrow_drop_down), // Icon for the dropdown
          ),
          VerticalDivider(
            width: 10,
            color: primaryColor, // Color of the vertical line
          ),
        ],
      ),
    );
  }
}
