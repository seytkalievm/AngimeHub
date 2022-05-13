import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/styles.dart';
import 'package:flutter/material.dart';

Widget info({required MediaQueryData mediaQuery, required MediaEntity media}) {
  return Column(
    children: [
      _firstLine(mediaQuery: mediaQuery, name: media.name),
      _secondLine(
        artistName: media.artist.toString(),
        artistPhoto: media.artist.profilePic,
      ),
    ],
  );
}

Widget _firstLine({required MediaQueryData mediaQuery, required String name}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
    child: _showName(mediaQuery: mediaQuery, name: name),
  );
}

Widget _showName({required MediaQueryData mediaQuery, required String name}) {
  return SizedBox(
    width: mediaQuery.size.width * 0.9,
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  );
}

Widget _secondLine({
  required String artistPhoto,
  required String artistName,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
    child: Row(children: [
      _photo(artistPhoto: artistPhoto),
      _name(artistName: artistName),
    ]),
  );
}

Widget _photo({required String artistPhoto}) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        artistPhoto,
        height: 65,
        width: 65,
      ),
    ),
    margin: const EdgeInsets.only(right: 10),
  );
}

Widget _name({required String artistName}) {
  return Text(
    artistName,
    style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 156, 160, 199)),
  );
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: CommonStyle.mainColor(),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 60.0,
          child: Column(
            children: [
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(255, 11, 191, 184),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
