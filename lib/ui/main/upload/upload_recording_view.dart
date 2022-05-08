import 'dart:io';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:angime_hub/ui/main/upload/upload_card.dart';
import 'package:angime_hub/ui/main/upload/upload_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../data/models/user_model.dart';

class UploadRecordingPage extends StatefulWidget {
  final User user;
  const UploadRecordingPage({required this.user, Key? key}) : super(key: key);

  @override
  State<UploadRecordingPage> createState() => _UploadRecordingState();
}

class _UploadRecordingState extends State<UploadRecordingPage> {
  late DataRepository dataRepo;
  String _type = 'Podcast';
  bool _fileChosen = false;
  bool _previewChosen = false;
  bool _mediaNameSet = false;
  late String _mediaName;
  late PlatformFile? _preview;
  late PlatformFile? _media;
  late ProgressDialog _progressDialog;


  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    _progressDialog = ProgressDialog(
      context,
      type:ProgressDialogType.Normal,
      isDismissible: false,
    );
    _progressDialog.style(
      message: 'Uploading Video...',
      borderRadius: 10.0,
      backgroundColor: CommonStyle.secondaryColor(),
      progressWidget: const CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: CommonStyle.descriptionTextStyle(),
      messageTextStyle: CommonStyle.headingTextStyle(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        context: context,
        pageTitle: 'Upload Recording',
        showProfileButton: false,
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
                  _uploadPreview(),
                  _uploadFile(),
                ],
              ),
              _navButtons(context),
            ],
          ),
        ),
      ],
      ),
    );
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
          CommonStyle.formName(formName: "Name of your recording"),
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
                _mediaName = value.trim();
                if (_mediaName == "") {
                  _mediaNameSet = false;
                }else{
                  _mediaNameSet = true;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadPreview(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label("Choose Preview"),
        _previewChosen? _selectedPreview() : _buttonSelect(_choosePreview),
      ],
    );
  }

  Widget _uploadFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label("Upload recording"),
        _fileChosen? _selectedVideo():_buttonSelect(_chooseMedia),
      ],
    );
  }

  Widget _buttonSelect(Function selectFile) {
    return Container(
      height: 42, 
      margin: const EdgeInsets.only(right: 16, left: 16),
      child: ElevatedButton(
        onPressed: () async {
          selectFile();
        },
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

  Widget _selectedPreview(){
    return Container(
      height: MediaQuery.of(context).size.width - 150,
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Image.file(
        File(_preview!.path!),
        fit: BoxFit.contain ,
      ),
    );
  }

  Widget _selectedVideo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Text(
        _media!.name,
        style: CommonStyle.textFieldInputStyle(),
      ),
    );
  }

  Widget _navButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Row(
        children: [
          Expanded(
            child: _cancelButton(),
          ),
          Expanded(
            child: (_fileChosen && _previewChosen && _mediaNameSet)
                ? _activeUploadButton(context)
                : _inactiveUploadButton(),
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
        onPressed: () {
          setState(() {
            _fileChosen = false;
            _previewChosen = false;
          });
        },
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

  Widget _activeUploadButton(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {
          _showMediaCard(context);
          },
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

  void _choosePreview() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );
    if (result != null){
      setState(() {
        _preview = result.files.first;
        _previewChosen = true;
      });
    }
  }

  void _chooseMedia() async{
    FileType _fileType = _type == 'Podcast'? FileType.audio : FileType.video;
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: _fileType
    );
    if (file != null){
      setState(() {
        _media = file.files.first;
        _fileChosen = true;
      });
    }
  }

  Future <void> _showMediaCard(BuildContext context)async{
    final entity = UploadEntity(
        preview: _preview!,
        media: _media!,
        user: widget.user,
        mediaName: _mediaName,
        type: _type == "Podcast"? 1 : 0);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: CommonStyle.secondaryColor(),
          title: const Text(
              "Upload media?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: UploadCard(entity: entity),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context, 'Cancel'),
            ),
            TextButton(
              child: const Text("Upload"),
              onPressed: () async {
                await _upload(context, entity);
                Navigator.pop(context, 'Upload');
              },
            ),
          ],
        );
      }
    );
  }


  Future <String> _upload(BuildContext context, UploadEntity media)async {
    setState(() {
      _progressDialog.show();
    });
    try{
      final response = await dataRepo.uploadFile(media);
      if (response.isNotEmpty){
        setState(() {
          _media = null;
          _preview = null;
          _mediaNameSet = false;
          _fileChosen = false;
          _previewChosen = false;
          _progressDialog.hide();
          var snackBar = SnackBar(
            content: Text(response),
            duration: const Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
      return response;
    } catch (e){
      var snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _progressDialog.hide();
      return "Error occured";
    }
  }


}
