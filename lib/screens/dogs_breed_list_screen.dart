import 'package:favoritee/data/dogs/local/BreedDao.dart';
import 'package:favoritee/data/dogs/local/BreedLocalApi.dart';
import 'package:favoritee/data/dogs/local/DartLocalDataSource.dart';
import 'package:favoritee/data/dogs/remote/DogsApiImp.dart';
import 'package:favoritee/data/dogs/remote/DogsRemoteDataSource.dart';
import 'package:favoritee/widget/Toast.dart';
import 'package:flutter/material.dart';

class DogsBreedListScreen extends StatefulWidget {
  const DogsBreedListScreen({Key? key}) : super(key: key);

  @override
  State<DogsBreedListScreen> createState() => _DogsBreedListScreenState();
}

class _DogsBreedListScreenState extends State<DogsBreedListScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isShow = false;
  bool isError = false;
  String errorMessage = "";
  late List<Breed> _list = [];

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
    _api = BreedDao(() {
      _load();
    });
    _breedsLocalDataSource = BreedsLocalDataSource(_api);
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
                "Dogs",
                style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            if (_selected.isNotEmpty)
              InkWell(
                onTap: () {
                  _saveFavorite();
                },
                child: const Text(
                  "Done",
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
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(errorMessage),
                      TextButton(
                          onPressed: () {
                            _load();
                          },
                          child: const Text("Try again"))
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
                  return InkWell(
                      onTap: () {
                        _list[index].isFave = !_list[index].isFave;
                        setState(() {
                          _markSelection();
                        });
                      },
                      child: Card(
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
                                _list[index].imageUrl),
                            Container(
                              margin: const EdgeInsets.fromLTRB(8, 5, 5, 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 2, 0),
                                          child: Text(
                                            _list[index].name.replaceFirst(
                                                _list[index].name[0],
                                                _list[index]
                                                    .name[0]
                                                    .toUpperCase()),
                                            style: TextStyle(
                                              color: Colors.grey[610],
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      children: [
                                        if (_list[index].isFave)
                                          const Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
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

  late List<BreedDbEntity> _selected = [];
  late BreedLocalApi _api;
  late BreedsLocalDataSource _breedsLocalDataSource;

  void _markSelection(){
    _selected = _list
        .where((element) => element.isFave)
        .map((element) =>
        BreedDbEntity(element.name, element.imageUrl, element.isFave))
        .toList();
  }
  void _load() async {
    setState(() {
      isShow = true;
      errorMessage = "";
      isError = false;
    });
    try {
      var api = DogsApiImp();
      var data = await DogsRemoteDataSource(api).get();
      for (var element in data) {
        print("name: ${element.name}, imageUrl:${element.imageUrl}");
      }
      setState(() {
        isShow = false;
        _list = data;
      });
    } catch (exception) {
      setState(() {
        isError = true;
        isShow = false;
        errorMessage = "Data loading failed";
      });
    }
  }

  void _saveFavorite() async {
    setState(() {
      isShow = true;
      errorMessage = "";
      isError = false;
    });
    try {

      await _breedsLocalDataSource.saveAllFavorites(_selected);
      if (context.mounted) {
        Navigator.pop(context, true);
      }
    } catch (exception) {
      setState(() {
        isError = true;
        isShow = false;
        errorMessage = "Could not perform save, try again";
      });
    }
  }
}
