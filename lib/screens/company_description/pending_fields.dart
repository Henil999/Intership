import 'package:flutter/material.dart';
import 'package:placement_app/screens/company_description/company_description_screen.dart';
import 'package:placement_app/widgets/cutom_textfield.dart';

// ignore: must_be_immutable
class PendingFields extends StatefulWidget {
  Map<String, dynamic> pendingKeys;

  PendingFields({super.key, required this.pendingKeys});

  @override
  State<PendingFields> createState() => _PendingFieldsState();
}

class _PendingFieldsState extends State<PendingFields> {
  List<TextEditingController> _controllers = [];

  List lst = [];
  void generateControllers(Map<String, dynamic> pendingKeys) {
    lst = pendingKeys["pendingKeys"] as List<dynamic>;
    _controllers = List.generate(lst.length, (index) => TextEditingController());
    // lst.forEach((field) {
    //   _controllers!.add(TextEditingController());
    // });
  }

  @override
  void initState() {
    super.initState();
    generateControllers(widget.pendingKeys);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.pendingKeys);
    // print(_controllers!.length);
    // var lst = widget.pendingKeys["pendingKeys"] as List<dynamic>;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: const Text(
            "Required Details",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: List<Widget>.generate(
                    lst.length,
                    (index) => textFields(
                          label: lst[index]["key"],
                          hintText: lst[index]["types"],
                          controller: _controllers[index],
                        )),
              ),
              const Spacer(),
              customButton("Submit", context, onPress: () {
                Map<String, dynamic> data = {};

                for (var i = 0; i < lst.length; i++) {
                  var e = lst[i];
                  var v = _controllers[i].text;
                  if (e['types'] == 'number') {
                    data[e['key']!] = double.tryParse(v) ?? 0;
                  } else if (e['types'] == 'bool') {
                    data[e['key']!] = bool.tryParse(v) ?? false;
                  } else {
                    data[e['key']!] = v;
                  }
                }
                Navigator.pop(context, data);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
