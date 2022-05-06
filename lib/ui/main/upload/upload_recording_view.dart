import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/content/requests.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:angime_hub/ui/main/content/media_card.dart';
import 'package:flutter/material.dart';

class UploadRecordingPage extends StatefulWidget {
  const UploadRecordingPage({Key? key}) : super(key: key);

  @override
  State<UploadRecordingPage> createState() => _UploadRecordingState();
}

class _UploadRecordingState extends State<UploadRecordingPage> {
  String _type = 'Podcast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(
          context: context,
          pageTitle: 'Upload Recording',
          showProfileButton: true,
        ),
        body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _selectType(),
                    _about(),
                    _upload(),
                  ],
                ),
                _navButtons(),
              ],
            ),
          ),
        ]));
  }

  Widget _selectType() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          _label("Select one"),
          _selectionBox(),
        ],
      ),
    );
  }

  Widget _selectionBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CommonStyle.secondaryColor(),
      ),
      child: Column(
        children: [
          _point(label: "Podcast"),
          _point(label: "Stand-Up Show"),
        ],
      ),
    );
  }

  Widget _point({String label = ''}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 23.5, 16, 23.5),
      child: ListTile(
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
      ),
    );
  }

  Widget _label(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 133, 135, 159),
        ),
      ),
    );
  }

  Widget _about() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        children: [
          CommonStyle.formName(formName: "Short description"),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: TextFormField(
              keyboardType: TextInputType.name,
              style: CommonStyle.textFieldInputStyle(),
              decoration: CommonStyle.textField(
                hintTextStr: "What is it about?",
              ),
              cursorColor: Colors.white,
              onChanged: (value) {
                value = value.trim();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _upload() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _label("Upload recording"),
          _buttonSelect(),
        ],
      ),
    );
  }

  Widget _buttonSelect() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 16, left: 16),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 72, 78, 128)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Select media from phone",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Open Sans",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _selectedVideo() {
    return MediaCard(
      media: show1,
      icon: MyFlutterApp.remove,
    );
  }

  Widget _navButtons() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Row(
        children: [
          Expanded(
            child: _cancelButton(),
          ),
          Expanded(
            child: _inactiveUploadButton(),
          ),
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 156, 160, 199)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Open Sans",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _inactiveUploadButton() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 11, 191, 184).withOpacity(0.4)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          "Upload",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Open Sans",
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  Widget _activeUploadButton() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 11, 191, 184)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Upload",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Open Sans",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
