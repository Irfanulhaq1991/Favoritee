import 'package:favoritee/data/dogs/local/BreedDao.dart';
import 'package:favoritee/data/dogs/local/BreedLocalApi.dart';
import 'package:favoritee/data/dogs/local/DartLocalDataSource.dart';
import 'package:favoritee/data/dogs/remote/DogsApiImp.dart';
import 'package:favoritee/data/dogs/remote/DogsRemoteDataSource.dart';
import 'package:favoritee/screens/dogs_breed_list_screen.dart';
import 'package:favoritee/widget/Toast.dart';
import 'package:flutter/material.dart';

class DogsFavoriteBreedScreen extends StatefulWidget {
  const DogsFavoriteBreedScreen({Key? key}) : super(key: key);

  @override
  State<DogsFavoriteBreedScreen> createState() => _DogsBreedListScreenState();
}

class _DogsBreedListScreenState extends State<DogsFavoriteBreedScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isShow = false;
  bool isError = false;
  String errorMessage = "";
  late List<BreedDbEntity> _list = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    api = BreedDao(() {
      print("dog dao initialised");
      load();
    });
    breedLocalSource = BreedsLocalDataSource(api);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
            ),
            const Expanded(
                child: Center(
              child: Text(
                "Favorite Dogs",
                style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            if (!isError)
              InkWell(
                onTap: () {
                  // save to db
                  _addFavorites();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.black, letterSpacing: 2.0, fontSize: 15),
                ),
              )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[600],
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            if (isError)
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(errorMessage),
                      TextButton(
                          onPressed: () {
                            _addFavorites();
                          },
                          child: const Text("Add breeds"))
                    ],
                  ))
            else
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 7.0,
                  crossAxisSpacing: 7.0,
                ),
                padding: const EdgeInsets.all(4.0),
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10,
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                            height: 150,
                            width: 180,
                            fit: BoxFit.fill,
                            _list[index].imageUrl_),
                        Container(
                          margin: const EdgeInsets.fromLTRB(8, 5, 5, 0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      _list[index].name_.replaceFirst(
                                          _list[index].name_[0],
                                          _list[index].name_[0].toUpperCase()),
                                      style: TextStyle(
                                        color: Colors.grey[610],
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _list[index].isFavorite_ =
                                            !_list[index].isFavorite_;
                                        dbBreeds.add(_list[index]);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        if (_list[index].isFavorite_)
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.amber,
                                          )
                                        else
                                          const Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.amber,
                                          ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            if (isShow)
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: CircularProgressIndicator(
                  value: controller.value,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                  semanticsLabel: 'Circular progress indicator',
                ),
              )
          ],
        ),
      )),
    );
  }

  late List<BreedDbEntity> dbBreeds = [];

  late BreedLocalApi api; //=  BreedDao(() {print("dog dao initialised");});
  late BreedsLocalDataSource breedLocalSource; // = BreedsLocalDataSource(api);

  void _addFavorites() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DogsBreedListScreen()));
    if (!mounted) return;
    load();
  }

  void load() async {
    setState(() {
      isShow = true;
      errorMessage = "";
      isError = false;
    });
    try {
      var data = await breedLocalSource.getAllFavorites();
      if (data.isEmpty) throw Exception();
      for (var element in data) {
        print("name: ${element.name_}, imageUrl:${element.imageUrl_}");
      }
      setState(() {
        isShow = false;
        _list = data;
      });
    } catch (exception) {
      print(exception.toString());
      setState(() {
        isError = true;
        isShow = false;
        errorMessage = "No favorite breed added yet";
      });
    }
  }

  void delete() async {
    try {
      setState(() {
        isShow = true;
        errorMessage = "";
        isError = false;
      });
      await breedLocalSource.deleteAllFavorites(dbBreeds);
      var data = await breedLocalSource.getAllFavorites();
      if (data.isEmpty) throw Exception();
      for (var element in data) {
        print("name: ${element.name_}, imageUrl:${element.imageUrl_}");
      }
      setState(() {
        isShow = false;
        _list = data;
      });
      dbBreeds.clear();
    } catch (exception) {
      setState(() {
        isError = true;
        isShow = false;
        errorMessage = "Could not perform deletion,try again";
      });
    }
  }
}
