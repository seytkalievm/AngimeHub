import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';

class UploadRecordingPage extends StatefulWidget {
  const UploadRecordingPage({Key? key}) : super(key: key);

  @override
  State<UploadRecordingPage> createState() => _UploadRecordingState();
}

class _UploadRecordingState extends State<UploadRecordingPage> {
  String _type = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
        fontFamily: "Open Sans",
        unselectedWidgetColor: const Color.fromARGB(255, 20, 22, 38),
      ),
      home: Scaffold(
        appBar: appBar(
          context: context,
          pageTitle: 'Upload Recording',
          showProfileButton: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _selectType(),
              _point(label: "Podcast"),
              _point(label: "Stand-Up Show"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _point({String label = ''}) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      leading: Radio<String>(
        activeColor: const Color.fromARGB(255, 11, 191, 184),
        value: label,
        groupValue: _type,
        onChanged: (String? value) {
          setState(
            () {
              _type = value!;
            },
          );
        },
      ),
    );
  }

  Widget _selectType() {
    return Column(
      children: [
        CommonStyle.formName(formName: "Select one"),
      ],
    );
  }
}
