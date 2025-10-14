import 'package:flutter/material.dart';
import 'dart:ui';
import 'breathwork_therapy_page.dart';
import 'programs_listing_page.dart';
import 'design_system.dart';

// App Colors
class AppColors {
  static const warmCream = Color(0xFFFFFDD0);
  static const dustyRose = Color(0xFFFADCD9);
  static const darkPlum = Color(0xFF4A2C4B);
  static const softGold = Color(0xFFD4AF37);
  static const lightPeach = Color(0xFFFFF5E6);
  static const lighterPlum = Color(0xFF6B4C6D);
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();

  // Mood-based collections
  List<Map<String, dynamic>> _getMoodCollections() {
    return [
      {
        'title': 'Zor Bir Konuşmadan Önce',
        'subtitle': 'Sakin ve odaklanmış ol',
        'icon': Icons.chat_bubble_outline,
        'gradient': [Color(0xFF87CEEB), Color(0xFF5F9FD9)],
        'itemCount': 5,
      },
      {
        'title': 'Yaratıcılığını Harekete Geçir',
        'subtitle': 'İlham ve akış',
        'icon': Icons.lightbulb_outline,
        'gradient': [Color(0xFFFFB6C1), Color(0xFFFF8FAB)],
        'itemCount': 7,
      },
      {
        'title': 'Panik Anında Acil Yardım',
        'subtitle': 'Hemen rahatlama',
        'icon': Icons.favorite_outline,
        'gradient': [Color(0xFFB8A5D4), Color(0xFF9C88C2)],
        'itemCount': 4,
      },
      {
        'title': 'Sabah Enerjisi',
        'subtitle': 'Güne başlamak için',
        'icon': Icons.wb_sunny_outlined,
        'gradient': [Color(0xFFFFA07A), Color(0xFFFF7F50)],
        'itemCount': 6,
      },
      {
        'title': 'Derin Odaklanma',
        'subtitle': 'Çalışma için ideal',
        'icon': Icons.center_focus_strong,
        'gradient': [Color(0xFF6A5ACD), Color(0xFF483D8B)],
        'itemCount': 8,
      },
    ];
  }

  // Content types
  List<Map<String, dynamic>> _getContentTypes() {
    return [
      {
        'title': 'Rehberli\nMeditasyonlar',
        'icon': Icons.headphones_outlined,
        'count': '50+ içerik',
        'color': Color(0xFFB8A5D4),
      },
      {
        'title': 'Nefes\nTerapileri',
        'icon': Icons.air,
        'count': '4 terapi',
        'color': Color(0xFF87CEEB),
      },
      {
        'title': 'Programlar',
        'icon': Icons.calendar_today_outlined,
        'count': '5 program',
        'color': Color(0xFFFFB6C1),
      },
      {
        'title': 'Müzikler\nve Sesler',
        'icon': Icons.music_note_outlined,
        'count': 'Yakında',
        'color': Color(0xFFFFA07A),
      },
    ];
  }

  // New content
  List<Map<String, dynamic>> _getNewContent() {
    return [
      {
        'title': 'Yeni: Sabah Meditasyonu',
        'duration': '12 Dakika',
        'type': 'Meditasyon',
        'gradient': [Color(0xFFFFA07A), Color(0xFFFF7F50)],
        'imageType': 'energy',
      },
      {
        'title': 'Yeni: 21 Günlük Şükran Programı',
        'duration': '8 Dakika',
        'type': 'Program',
        'gradient': [Color(0xFFFFB6C1), Color(0xFFFF8FAB)],
        'imageType': 'gratitude',
      },
      {
        'title': 'Yeni: Hızlı Sakinleşme',
        'duration': '5 Dakika',
        'type': 'Nefes',
        'gradient': [Color(0xFFB8A5D4), Color(0xFF9C88C2)],
        'imageType': 'breathwork',
      },
    ];
  }

  // Popular topics/tags
  List<String> _getPopularTopics() {
    return [
      'Özgüven',
      'Affetmek',
      'Sabah Rutini',
      'Motivasyon',
      'Kabul',
      'Yas',
      'Minnettarlık',
      'Öfke Yönetimi',
      'İlişkiler',
      'Kendini Sevmek',
      'Sabır',
      'Korku',
      'Yalnızlık',
      'Değişim',
      'Bırakmak',
    ];
  }

  // Popular search terms
  List<String> _getPopularSearches() {
    return [
      'uyku',
      'stres',
      'kaygı',
      'motivasyon',
      'özgüven',
      'nefes çalışması',
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          // Header with Search
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Keşfet',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      color: AppColors.darkPlum,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sana uygun içeriği keşfet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkPlum.withOpacity(0.6),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Smart Search Bar
                  _buildSearchBar(),
                ],
              ),
            ),
          ),

          // Mood-Based Collections
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Text(
                    'Bugün Sana Ne İyi Gelir?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkPlum,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _getMoodCollections().length,
                    itemBuilder: (context, index) {
                      final collection = _getMoodCollections()[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildMoodCard(collection),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content Types Grid
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Text(
                    'İçerik Türleri',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkPlum,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildContentTypesGrid(),
                ),
              ],
            ),
          ),

          // New Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGold,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'YENİ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Kozmos\'taki Yenilikler',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkPlum,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _getNewContent().length,
                    itemBuilder: (context, index) {
                      final item = _getNewContent()[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildNewContentCard(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Popular Topics
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Text(
                    'Popüler Konular',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkPlum,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildTopicsCloud(),
                ),
                const SizedBox(height: 100), // Bottom spacing
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        _showSearchSheet();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(
              Icons.search,
              color: AppColors.darkPlum.withOpacity(0.4),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Bir konu veya duygu ara... (uyku, yalnızlık)',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.darkPlum.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.warmCream,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.darkPlum.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Search Input
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkPlum.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.darkPlum,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ara...',
                    hintStyle: TextStyle(
                      color: AppColors.darkPlum.withOpacity(0.4),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.darkPlum.withOpacity(0.4),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppColors.darkPlum.withOpacity(0.4),
                      ),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Popular Searches
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popüler Aramalar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkPlum,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._getPopularSearches().map((search) {
                      return InkWell(
                        onTap: () {
                          _searchController.text = search;
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.darkPlum.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: AppColors.softGold,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  search,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkPlum,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.darkPlum.withOpacity(0.3),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard(Map<String, dynamic> collection) {
    return GestureDetector(
      onTap: () {
        // Navigate to collection detail
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${collection['title']} koleksiyonu açılıyor...'),
            backgroundColor: AppColors.darkPlum,
          ),
        );
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Gradient Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: collection['gradient'],
                    ),
                  ),
                ),
              ),

              // Glassmorphism Overlay
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          collection['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),

                      // Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            collection['subtitle'],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${collection['itemCount']} içerik',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentTypesGrid() {
    final types = _getContentTypes();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types[index];
        return _buildContentTypeCard(type);
      },
    );
  }

  Widget _buildContentTypeCard(Map<String, dynamic> type) {
    return GestureDetector(
      onTap: () {
        // Navigate based on type
        if (type['title'].contains('Rehberli')) {
          // Show all meditations
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tüm meditasyonlar gösteriliyor...'),
              backgroundColor: AppColors.darkPlum,
            ),
          );
        } else if (type['title'].contains('Nefes')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BreathworkTherapyListPage(),
            ),
          );
        } else if (type['title'].contains('Program')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProgramsListingPage(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: type['color'].withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                type['icon'],
                color: type['color'],
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                type['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkPlum,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              type['count'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.darkPlum.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContentCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // Navigate to content
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['title']} açılıyor...'),
            backgroundColor: AppColors.darkPlum,
          ),
        );
      },
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPlum.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Gradient Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: item['gradient'],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item['type'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['duration'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicsCloud() {
    final topics = _getPopularTopics();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: topics.map((topic) {
        return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$topic konusu aranıyor...'),
                backgroundColor: AppColors.darkPlum,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.darkPlum.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkPlum.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              topic,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.darkPlum,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
