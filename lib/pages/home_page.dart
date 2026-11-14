
import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_tile.dart';
import 'package:resepku/widgets/recipe_grid_card.dart';
import 'package:resepku/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGrid = false;

  // State untuk filter cuisine
  String? _cuisine;

  @override
  Widget build(BuildContext context) {
    // Mengambil cuisine secara otomatis dari data
    final cuisines = dummyRecipes
        .map((recipe) => recipe.cuisine)
        .toSet()
        .toList();

    // Filter resep berdasarkan cuisine yang dipilih
    final filteredRecipes = _cuisine == null
        ? dummyRecipes
        : dummyRecipes
            .where((recipe) => recipe.cuisine == _cuisine)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 32),
            const SizedBox(width: 8),
            const Text('ResepKu'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'Tampilan list' : 'Tampilan Grid',
            icon: Icon(
              _isGrid ? Icons.view_list : Icons.grid_view,
            ),
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
          ),
          const FavoriteBadgeButton(),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Pengaturan',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            ),
          ),
        ],
      ),

      // Body menggunakan Column
      body: Column(
        children: [
          // Deretan ChoiceChip horizontal
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: _cuisine == null,
                  onSelected: (selected) {
                    setState(() {
                      _cuisine = null;
                    });
                  },
                ),

                const SizedBox(width: 8),

                ...cuisines.map((cuisine) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cuisine),
                      selected: _cuisine == cuisine,
                      onSelected: (selected) {
                        setState(() {
                          _cuisine = selected ? cuisine : null;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          // List atau Grid mengisi sisa layar
          Expanded(
            child: _isGrid
                ? _buildGrid(filteredRecipes)
                : _buildList(filteredRecipes),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeTile(recipe: recipes[index]);
      },
    );
  }

  Widget _buildGrid(List recipes) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeGridCard(
          recipe: recipes[index],
        );
      },
    );
  }
}
