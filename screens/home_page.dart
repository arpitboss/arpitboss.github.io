import 'package:atg_assignment/models/lessons.dart';
import 'package:atg_assignment/models/programs.dart';
import 'package:atg_assignment/services/api_service.dart';
import 'package:atg_assignment/widgets/custom_appbar.dart';
import 'package:atg_assignment/widgets/grid_item.dart';
import 'package:atg_assignment/widgets/list_item.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RxInt _selectedIndex = 0.obs;
  late Future<Programs?> _futurePrograms;
  late Future<Lessons?> _futureLessons;
  late bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
      if (_isConnected) {
        _fetchData();
      }
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
    if (_isConnected) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    _futurePrograms = ApiService.fetchPrograms();
    _futureLessons = ApiService.fetchLessons();
  }

  Future<void> _refreshData() async {
    await _fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingIcon: Icons.view_sidebar,
        trailingIcon1: Icons.message_outlined,
        trailingIcon2: Icons.notifications,
        preferredHeight: kToolbarHeight,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xf4f6fbff),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Priya!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'),
                      ),
                      const Text(
                        'What do you wanna learn today?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 30),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio: 2),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (_, index) => buildGridItem(
                                _getIconData(index),
                                _getText(index),
                              )),
                    ],
                  ),
                ),
              ),
              if (_isConnected)
                SizedBox(
                  height: 320,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '  Programs for you',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(
                                    color: Colors.black,
                                    fontFamily: 'Times New Roman',
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Row(
                                      children: [
                                        Text(
                                          'View All',
                                          style: TextStyle(
                                              fontFamily: 'Times New Roman'),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: FutureBuilder<Programs?>(
                            future: _futurePrograms,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                if (kDebugMode) {
                                  print(snapshot.data!.items!.length);
                                }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => buildListItem(
                                    snapshot.data!.items![index].name ?? '',
                                    snapshot.data!.items![index].category ?? '',
                                    '${snapshot.data!.items![index].lesson} lessons',
                                    _getImage(index),
                                  ),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 0),
                                  itemCount: snapshot.data!.items!.length,
                                );
                              } else {
                                return const Center(
                                    child: Text('No data available'));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Text('No Internet Connection'),
                ),
              if (_isConnected)
                SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '  Lessons for you',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(
                                    color: Colors.black,
                                    fontFamily: 'Times New Roman',
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Row(
                                      children: [
                                        Text(
                                          'View All',
                                          style: TextStyle(
                                              fontFamily: 'Times New Roman'),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: FutureBuilder<Lessons?>(
                            future: _futureLessons,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                if (kDebugMode) {
                                  print(snapshot.data!.items!.length);
                                }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => buildListItem(
                                    snapshot.data!.items![index].name ?? '',
                                    snapshot.data!.items![index].category ?? '',
                                    '${snapshot.data!.items![index].duration} minutes',
                                    _getImage(index),
                                  ),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 0),
                                  itemCount: snapshot.data!.items!.length,
                                );
                              } else {
                                return const Center(
                                    child: Text('No data available'));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Text('No Internet Connection'),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blueAccent[200]!,
        items: [
          _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
          _buildBottomNavigationBarItem(Icons.menu_book_rounded, 'Learn', 1),
          _buildBottomNavigationBarItem(Icons.hub_outlined, 'Hub', 2),
          _buildBottomNavigationBarItem(Icons.chat_bubble_rounded, 'Chat', 3),
          _buildBottomNavigationBarItem(Icons.person, 'Profile', 4),
        ],
        currentIndex: _selectedIndex.value,
        onTap: (index) {
          _selectedIndex.value = index;
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: Colors.transparent,
      activeIcon: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 3,
              color: Colors.blue,
            ),
          ),
          Center(
            child: Icon(
              icon,
              color: Colors.blueAccent[200]!,
            ),
          ),
        ],
      ),
    );
  }

  String _getText(int index) {
    switch (index) {
      case 0:
        return 'Programs';
      case 1:
        return 'Get help';
      case 2:
        return 'Learn';
      case 3:
        return 'DD Tracker';
      default:
        return 'Error';
    }
  }

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.book_rounded;
      case 1:
        return Icons.help;
      case 2:
        return Icons.menu_book_rounded;
      case 3:
        return Icons.track_changes_sharp;
      default:
        return Icons.error;
    }
  }

  String _getImage(int index) {
    switch (index) {
      case 0:
        return 'assets/babyfeed.png';
      case 1:
        return 'assets/natarajasana.png';
      case 2:
        return 'assets/babyfeed.png';
      case 3:
        return 'assets/natarajasana.png';
      case 4:
        return 'assets/babyfeed.png';
      case 5:
        return 'assets/natarajasana.png';
      case 6:
        return 'assets/babyfeed.png';
      case 7:
        return 'assets/natarajasana.png';
      case 8:
        return 'assets/babyfeed.png';
      case 9:
        return 'assets/natarajasana.png';
      case 10:
        return 'assets/babyfeed.png';
      case 11:
        return 'assets/natarajasana.png';
      case 12:
        return 'assets/babyfeed.png';
      case 13:
        return 'assets/natarajasana.png';
      case 14:
        return 'assets/babyfeed.png';
      case 15:
        return 'assets/natarajasana.png';
      case 16:
        return 'assets/babyfeed.png';
      case 17:
        return 'assets/natarajasana.png';
      case 18:
        return 'assets/babyfeed.png';
      case 19:
        return 'assets/natarajasana.png';
      case 20:
        return 'assets/babyfeed.png';
      case 21:
        return 'assets/natarajasana.png';
      case 22:
        return 'assets/babyfeed.png';
      case 23:
        return 'assets/natarajasana.png';
      case 24:
        return 'assets/babyfeed.png';
      case 25:
        return 'assets/natarajasana.png';
      case 26:
        return 'assets/babyfeed.png';
      case 27:
        return 'assets/natarajasana.png';
      case 28:
        return 'assets/babyfeed.png';
      case 29:
        return 'assets/natarajasana.png';
      default:
        return 'Error';
    }
  }
}
