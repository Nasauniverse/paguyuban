import 'package:flutter/material.dart';
import 'package:paguyuban/models/perpustakaan.dart';

class PerpustakaanViewModel extends ChangeNotifier {
  List<Book> books = [
    Book(
        name: 'To Kill a Mockingbird',
        imageUrl: "assets/buku_infografis/buku1.jpeg"),
    Book(name: 'Buku Dua2', imageUrl: "assets/buku_infografis/buku2.jpeg"),
    Book(name: 'Buku Tiga3', imageUrl: "assets/buku_infografis/buku3.jpeg"),
    Book(name: 'Buku Empat4', imageUrl: "assets/buku_infografis/buku4.jpeg"),
    Book(name: 'Buku Lima5', imageUrl: "assets/buku_infografis/buku5.jpeg"),
    Book(name: 'Buku Enam6', imageUrl: "assets/buku_infografis/buku6.jpeg"),
    Book(name: 'Buku Tujuh7', imageUrl: "assets/buku_infografis/buku7.jpeg"),
    Book(name: 'Buku Delapan8', imageUrl: "assets/buku_infografis/buku8.jpeg"),
    Book(name: 'Buku Sembilan9', imageUrl: "assets/buku_infografis/buku9.jpeg"),
    Book(name: 'Buku Sepuluh10', imageUrl: "assets/buku_infografis/buku10.jpeg"),
  ];
}
