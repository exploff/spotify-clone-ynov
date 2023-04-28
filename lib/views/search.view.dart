import 'package:flutter/material.dart';
import 'package:spoticlone/components/circular_progressor.component.dart';
import 'package:spoticlone/components/track_preview.component.dart';
import 'package:spoticlone/models/album.mode.dart';
import 'package:spoticlone/models/track.model.dart';
import 'package:spoticlone/repository/http.jamendo.service.dart';
import 'package:spoticlone/components/album_preview.component.dart';
import 'package:searchfield/searchfield.dart';
import 'package:spoticlone/views/album.view.dart';
import 'package:spoticlone/views/search_music.view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  int offset = 0;

  List<Album> albums = [];
  bool loader = true;
  bool onSearch = false;
  bool onSearchSubmit = false;

  List<Track> tracks = [];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_getSuggestions);

    JamendoHttp().getAlbums(offset).then((values) {
      setState(() {
        albums.addAll(values);
        loader = false;
      });
    });

  }


  _getSuggestions() {
    if (_searchController.text.length > 3 && !onSearch) {
      setState(() {
        onSearch = true;
      });

      JamendoHttp().searchTrack(_searchController.text).then((values) {
        setState(() {
          tracks = values;
          onSearch = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchSubmit() {
    setState(() {
      onSearchSubmit = true;
    });

    JamendoHttp().searchTrack(_searchController.text, 20).then((values) {
      setState(() {
        tracks = values;
        onSearchSubmit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        loader ? 
        const CircularProgressorCustom() :
        SizedBox(
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20, top: 20)),
                  Text("Top Albums", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)
                ]
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumView(album: albums[index]),
                            ),
                          );
                        },
                        child: AlbumPreview(album: albums[index])
                      ),
                    );
                  }
                ),
              ),              
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20, top: 20)),
                        Text("Recherche un son", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                      ]
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: SearchField<Track>(
                              controller: _searchController,
                              suggestions: tracks
                                .map(
                                (e) => SearchFieldListItem<Track>(
                                    e.name!,
                                    item: e,
                                    // Use child to show Custom Widgets in the suggestions
                                    // defaults to Text widget
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(e.image!),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(e.name!.length > 25 ? '${e.name!.substring(0, 25)} ...' : e.name!),
                                        ],
                                      ),
                                    ),
                                ),
                              )
                              .toList(),
                              searchInputDecoration: InputDecoration(
                                prefixIcon: const Icon(Icons.music_note),
                                prefixIconColor: const Color.fromARGB(255, 154, 161, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(176, 255, 255, 255),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:  const BorderSide(color: Color.fromARGB(255, 154, 161, 255),),
                                )
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  searchSubmit();
                                  print(_searchController.text);
                                }
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(const Color.fromARGB(255, 154, 161, 255),),
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder()
                                ),
                              ),
                              child: const Icon(Icons.search),
                            ), 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onSearchSubmit ?
              const CircularProgressorCustom() :
              tracks.isEmpty ?
              const Text("Aucun resultat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),) :
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  itemCount: tracks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (tracks[index].audio ==  "" || tracks[index].audio == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ce morceau n\'est pas disponible'),
                                backgroundColor: Colors.red,
                            )
                          );
                          } else {
                            Navigator.push(context,
                              MaterialPageRoute(  
                                builder: (BuildContext context) => SearchMusicView(song: tracks[index],)
                              )
                            );
                          }
                        },
                        child: Column(
                          children: [
                            TrackPreview(track: tracks[index]),
                            index < tracks.length - 1 ?
                            const Divider(color: Colors.white, height: 25, thickness: 1,):
                              Container()
                          ],
                        )
                      ),
                    );
                  }
                ),
              ),  
            ],
          ),
        ),
      ],
    );
  }
}