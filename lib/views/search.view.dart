import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(padding: EdgeInsets.only(left: 10, top: 10)),
                  Text("Top Albums", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
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
                    const Text("Recherche un son"),
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
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.8),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
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
              const Text('Aucun résultat') :
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
                        child: TrackPreview(track: tracks[index])
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