import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/article_w.dart';
import 'package:flutter/material.dart';
import '../data/tp.dart';
import 'package:provider/provider.dart';
import '../services/news_api_service.dart';
import '../providers/darkmode_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  
  final List<String> categories = const [
    'All',
    'Politics',
    'Tech',
    'Sports',
    'Entertainment',
    'Health',
    'Science',
    'World',
  ];
  late Future<List<Article>> _futureArticles = Future.value([]); 

  @override
  void initState() {
    super.initState();
    _futureArticles = NewsApiService().fetchTopHeadlines();
  }
  
  @override
  Widget build(BuildContext context) {
    final darkmodeProvider = Provider.of<DarkmodeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        
      automaticallyImplyLeading: false, 
      title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            height: kToolbarHeight, 
          ),
        ),
        centerTitle: false,
    //    title: const Text('ACM NEWS APP'),
        actions: [
          Switch(
            activeColor: Colors.white,
            activeTrackColor: Colors.blueAccent,
            //title: const Text('Dark Mode'),
            value: darkmodeProvider.isDarkMode,
            onChanged: (value) {
              darkmodeProvider.toggleDM(value);
            },
          ),
          IconButton(onPressed: (){
          Navigator.pushNamed(context,'/settings');
        }, icon: const Icon(Icons.settings))],
        ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }
          final filteredArticles = selectedCategory == 'All'
              ? snapshot.data!
              : snapshot.data!
                  .where((a) => a.category == selectedCategory)
                  .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal Category Tags
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_){
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.blueAccent,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                    color: selectedCategory == category ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredArticles.length,
                  itemBuilder: (context, index) {
                    return ArticleW(
                      article: filteredArticles[index],
                      onTap: () {},
                      onBookmarkToggle: () {},
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.pushNamed(context, '/bookmarks');
        },
        tooltip: 'Open Bookmarks Page',
        child: const Icon(Icons.bookmark),
      ),
    );
  }
}
