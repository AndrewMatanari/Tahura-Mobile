import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahura_mobile/screen/detailproduk_screen.dart';

class Katalog extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'assets/img/image 11.png',
      'title': 'Topi Rotan',
      'category': 'Topi',
      'price': 'Rp. 30.000',
    },
    {
      'image': 'assets/img/image 14.png',
      'title': 'Gantungan Lampu',
      'category': 'Accessories',
      'price': 'Rp. 25.000',
    },
    {
      'image': 'assets/img/image 13.png',
      'title': 'Nampan Rotan',
      'category': 'Peralatan Dapur',
      'price': 'Rp. 40.000',
    },
    {
      'image': 'assets/img/image 12.png',
      'title': 'Keranjang Rotan',
      'category': 'Accessories',
      'price': 'Rp. 50.000',
    },
    {
      'image': 'assets/img/image 10.png',
      'title': 'Kursi Nenek Turbo',
      'category': 'Mebel',
      'price': 'Rp. 200.000',
    },
    {
      'image': 'assets/img/tas 2.png',
      'title': 'Tas Wanita Rotan',
      'category': 'Women’s Bags',
      'price': 'Rp. 70.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Katalog Produk',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0).copyWith(top: 0.0, bottom: 0.0).copyWith(left: 10, right: 10),
        child: Container(
          color: Colors.white,
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return HoverableProductCard(product: product);
            },
          ),
        ),
      ),
    );
  }
}

class HoverableProductCard extends StatefulWidget {
  final Map<String, String> product;

  const HoverableProductCard({Key? key, required this.product})
      : super(key: key);

  @override
  _HoverableProductCardState createState() => _HoverableProductCardState();
}

class _HoverableProductCardState extends State<HoverableProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      onTapDown: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.teal.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 15 : 10,
              spreadRadius: _isHovered ? 3 : 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                widget.product['image']!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['title']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.product['category']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['price']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Katalog(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
  ));
}

