import 'icons.dart';
import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  final String header;
  final String hint;
  final String popular;

  const ContentPage(
      {required this.header,
      required this.hint,
      required this.popular,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(255, 20, 22, 38),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Header(
                header: widget.header,
                hint: widget.hint,
                popular: widget.popular,
              )
            ],
          )),
        ));
  }
}

class Header extends StatefulWidget {
  final String header;
  final String hint;
  final String popular;

  const Header(
      {required this.header,
      required this.hint,
      required this.popular,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              child: Text(
                widget.header,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    fontFamily: "OpenSans",
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              height: 38,
              width: 225,
            ),
            const Center(
                child: SizedBox(
              width: 32,
              height: 32,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 156, 160, 199),
                radius: 32,
                child: Icon(
                  MyFlutterApp.account,
                  size: 24,
                ),
              ),
            ))
          ]),
          margin: const EdgeInsets.fromLTRB(16, 40, 16, 10),
        ),
        Container(
          child: TextField(
              style: const TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255)),
              decoration: InputDecoration(
                  prefixIcon: const Padding(
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 133, 135, 159),
                      size: 18,
                    ),
                    padding: EdgeInsets.fromLTRB(20, 11, 10, 11),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 133, 135, 159),
                      fontFamily: "OpenSans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  fillColor: const Color.fromARGB(255, 42, 45, 71),
                  contentPadding:
                      const EdgeInsets.fromLTRB(0, 13.5, 15, 13.5))),
          height: 46,
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        ),
        const PopularArtists(),
        PopularShows(popular: widget.popular)
      ],
    );
  }
}

class PopularArtists extends StatefulWidget {
  const PopularArtists({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopularArtistsState();
}

class PopularArtistsState extends State<PopularArtists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: const Padding(
              child: Text(
                "Popular artists",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 133, 135, 159)),
              ),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
              child: SizedBox(
                height: 125,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(6, (index) {
                    int i = (index + 1) % 3;
                    if (i == 0) {
                      i = 3;
                    }
                    String name = i.toString();
                    return Card(name: name);
                  }),
                ),
              ))
        ],
      ),
      margin: const EdgeInsets.fromLTRB(0, 34, 0, 0),
    );
  }
}

class Card extends StatelessWidget {
  final String name;

  const Card({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/images/$name.png', height: 97, width: 95),
          Container(
            height: 16,
            width: 95,
            alignment: Alignment.centerLeft,
            child: const Text(
              "Alex",
              style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
          )
        ],
      ),
      margin: const EdgeInsets.only(right: 10),
    );
  }
}

class PopularShows extends StatefulWidget {
  final String popular;
  const PopularShows({required this.popular, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopularShowsState();
}

class PopularShowsState extends State<PopularShows> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Padding(
              child: Text(
                widget.popular,
                style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 133, 135, 159)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(6, (index) {
                int i = (index + 1) % 4;
                if (i == 0) {
                  i = 4;
                }
                String name = i.toString();
                return ShowCard(name: name);
              }),
            ),
          )
        ],
      ),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 0),
    );
  }
}

class ShowCard extends StatelessWidget {
  final String name;

  const ShowCard({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Image.asset('assets/images/s$name.png', height: 60, width: 83),
            Container(
              child: Column(
                children: const [
                  Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text("Name",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255)))),
                  Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text("Alex K.",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 156, 160, 199)))),
                  Text("44 min",
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 156, 160, 199))),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            )
          ]),
          const SizedBox(
            child: Icon(
              MyFlutterApp.download,
              size: 16,
              color: Color.fromARGB(255, 156, 160, 199),
            ),
          )
        ],
      ),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    );
  }
}
