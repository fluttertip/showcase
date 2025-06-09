import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app showcase',
      theme: ThemeData(
      brightness: Brightness.dark,
        useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const ShowcaseHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShowcaseHomePage extends StatefulWidget {
  const ShowcaseHomePage({super.key});

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final Map<String, Map<String, dynamic>> apps = {
    'QuickChat': {
      'desc': 'Clean and responsive messaging UI.',
      'images': List.generate(3, (i) => 'assets/images/${i + 1}.jpg'),
    },
    'finly': {
      'desc': 'Finance tracking with charts and expenses.',
      'images': List.generate(7, (i) => 'assets/images/${i + 4}.jpg'),
    },
    'FitTrack': {
      'desc': 'Health & fitness dashboard and progress.',
      'images': List.generate(7, (i) => 'assets/images/${i + 11}.jpg'),
    },
    'HireMe': {
      'desc': 'Job listings and hiring flows.',
      'images': List.generate(13, (i) => 'assets/images/${i + 18}.jpg'),
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: apps.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('work showcase'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: apps.keys.map((name) => Tab(text: name)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: apps.entries.map((entry) {
          final name = entry.key;
          final desc = entry.value['desc'] as String;
          final images = entry.value['images'] as List<String>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headlineMedium),
                  Text(desc, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 12),
                  ...images.map((path) => _buildImageCard(path)).toList(),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildImageCard(String path) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // child: AspectRatio(
      // aspectRatio: 4 / 3,

      // Typical mobile device aspect ratio
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        color: Colors.black, // Optional: adds a border/background like a phone
        child: Padding(
          padding: const EdgeInsets.all(
            8.0,
          ), // Optional: simulates device bezel
          // child: InteractiveViewer(
          //   minScale: 0.5,
          //   maxScale: 4.0,
          //   child: Image.asset(
          //     path,
          //     fit: BoxFit.contain,
          //     errorBuilder: (context, error, stackTrace) =>
          //         const Center(child: Icon(Icons.broken_image)),
          //   ),
          // ),
          child: Image.asset(
            path,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      ),
      // ),
    );
  }
}
