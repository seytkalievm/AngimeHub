import 'dart:io';
import 'package:angime_hub/ui/main/upload/upload_entity.dart';
import 'package:flutter/material.dart';

class UploadCard extends StatelessWidget{
  final UploadEntity entity;
  const UploadCard({required this.entity, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _preview(),
            Stack(
              alignment:  Alignment.centerLeft,
              children: [
                _info(),
              ],
            )
          ],
        ),
      ],
    );

  }

  Widget _preview(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.file(
        File(entity.preview.path!),
        height: 60,
        width: 83,
      ),
    );
  }

  Widget _info(){
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _name(),
          _artist(),
        ],
      ),
    );
  }

  Widget _name(){
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        entity.mediaName,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _artist(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        "${entity.user.firstName} ${entity.user.secondName}",
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 156, 160, 199),
        ),
      ),
    );
  }

}