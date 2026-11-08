import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
import 'package:resepku/providers/favorite_provider.dart'; 
  
class FavoritePage extends StatelessWidget { 
  const FavoritePage({super.key}); 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Favorit Saya'),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favorite, child) {
              return TextButton(
                onPressed: favorite.count == 0
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Hapus semua favorit?'),
                              content: const Text(
                                'Apakah kamu yakin ingin menghapus semua resep favorit?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    favorite.clear();
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                child: const Text('Hapus semua'),
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoriteProvider>( 
        builder: (context, favorite, child) { 
          if (favorite.count == 0) { 
            return const Center( 
              child: Text( 
                'Belum ada resep favorit.\nTekan ikon hati di daftar resep.', 
                textAlign: TextAlign.center, 
              ), 
            ); 
          } 
          return ListView( 
            children: [ 
              for (final recipe in favorite.items) 
                ListTile( 
                  title: Text(recipe.name), 
                  subtitle: Text(recipe.cuisine), 
                  trailing: IconButton( 
                    icon: const Icon(Icons.delete_outline), 
                    onPressed: () => favorite.toggle(recipe), 
                  ), 
                ), 
            ], 
          ); 
        }, 
      ), 
    ); 
  } 
} 