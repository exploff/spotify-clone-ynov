import 'package:flutter/material.dart';
import 'package:spoticlone/views/musics.view.dart';
import 'package:spoticlone/views/list_radio.view.dart';
import 'package:spoticlone/views/search.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.radio),
              text: 'Radio',
            ),
            Tab(
              icon: Icon(Icons.music_note),
              text: 'Musiques',
            ),
            Tab(
              icon: Icon(Icons.search),
              text: 'Recherche',
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 154, 161, 255),
              Color.fromARGB(255, 46, 9, 121),
            ],
          )
        ),
        child: Column(
          children: const [
            SizedBox(height: 50),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: ListRadioView(),
                  ),
                  Center(
                    child: MusicsView(),
                  ),
                  SearchView()
                ],
              ),
            ),
          ],
        ),
      ), 
    );
  }
}