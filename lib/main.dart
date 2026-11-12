
import 'package:flutter/material.dart';

void main() => runApp(const ADStore());

const bg = Color(0xFF0D0B14);
const card = Color(0xFF1B1726);
const green = Color(0xFF39D98A);
const purple = Color(0xFF7027B9);

class Product {
  final String name, price, image, initials;
  final Color color;

  const Product(this.name, this.price, this.image, this.initials, this.color);
}

final Map<String, List<Product>> catalog = {
  'الألعاب': [
    Product('PUBG Mobile', '5.00', 'https://cdn.simpleicons.org/pubg', 'PUBG', Colors.orange),
    Product('Free Fire', '3.00', 'https://cdn.simpleicons.org/garena', 'FF', Colors.deepOrange),
    Product('بيلباردو', '2.00', '', 'ب', Colors.blue),
    Product('جواكر', '2.00', '', 'جواكر', Colors.red),
  ],
  'التطبيقات': [
    Product('Junko', '3.00', '', 'J', Colors.pink),
    Product('Tami', '3.00', '', 'T', Colors.cyan),
    Product('Pota Live', '4.00', '', 'POTA', Colors.purple),
    Product('Zaffa Live', '4.00', '', 'ZAFFA', green),
    Product('Ume', '3.00', '', 'UME', Colors.teal),
  ],
  'الاشتراكات': [
    Product('Netflix', '8.00', 'https://cdn.simpleicons.org/netflix/E50914', 'N', Colors.red),
    Product('Shahid', '6.00', '', 'SHAHID', Colors.purple),
    Product('Spotify Premium', '5.00', 'https://cdn.simpleicons.org/spotify/1DB954', 'S', green),
    Product('YouTube Premium', '6.00', 'https://cdn.simpleicons.org/youtube/FF0000', 'YT', Colors.red),
    Product('Disney+', '7.00', 'https://cdn.simpleicons.org/disneyplus/113CCF', 'D+', Colors.blue),
    Product('Canva Pro', '5.00', 'https://cdn.simpleicons.org/canva/00C4CC', 'C', Colors.cyan),
  ],
};

class ADStore extends StatefulWidget {
  const ADStore({super.key});

  @override
  State<ADStore> createState() => _ADStoreState();
}

class _ADStoreState extends State<ADStore> {
  final List<Product> cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: green,
          secondary: purple,
        ),
      ),
      home: HomePage(
        cart: cart,
        onCartChanged: () => setState(() {}),
      ),
    );
  }
}

// AD LOGO WITH CROWN

class ADLogo extends StatelessWidget {
  final double size;
  const ADLogo({super.key, this.size = 70});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.5,
      height: size * 1.25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Icon(
              Icons.workspace_premium,
              color: const Color(0xFFFFD166),
              size: size * .38,
            ),
          ),
          Positioned(
            bottom: 0,
            child: ShaderMask(
              shaderCallback: (bounds) =>
                  const LinearGradient(
                colors: [green, purple],
              ).createShader(bounds),
              child: Text(
                'AD',
                style: TextStyle(
                  fontSize: size * .72,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PRODUCT IMAGE

class ProductImage extends StatelessWidget {
  final Product product;
  final double size;

  const ProductImage({
    super.key,
    required this.product,
    this.size = 85,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: product.color.withOpacity(.65),
          width: 1.3,
        ),
      ),
      child: product.image.isEmpty
          ? Center(
              child: FittedBox(
                child: Text(
                  product.initials,
                  style: TextStyle(
                    color: product.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            )
          : Image.network(
              product.image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Center(
                child: Text(
                  product.initials,
                  style: TextStyle(
                    color: product.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}

// HOME PAGE: ONLY THREE CATEGORIES

class HomePage extends StatelessWidget {
  final List<Product> cart;
  final VoidCallback onCartChanged;

  const HomePage({
    super.key,
    required this.cart,
    required this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: const Text(
          'AD STORE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${cart.length}'),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: green,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    cart: cart,
                    onChanged: onCartChanged,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          const Center(child: ADLogo(size: 95)),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'YOUR DIGITAL WORLD',
              style: TextStyle(
                color: green,
                letterSpacing: 3,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF25203A),
                  Color(0xFF10251F),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: purple),
            ),
            child: const Column(
              children: [
                Text(
                  'مرحباً بك في AD STORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'كل خدماتك الرقمية في مكان واحد',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'الأقسام الرئيسية',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          CategoryTile(
            title: 'الألعاب',
            subtitle: 'PUBG • Free Fire • والمزيد',
            icon: Icons.sports_esports,
            color: Colors.orange,
            onTap: () => openCategory(context, 'الألعاب'),
          ),
          const SizedBox(height: 15),
          CategoryTile(
            title: 'التطبيقات',
            subtitle: 'Junko • Tami • Pota Live',
            icon: Icons.apps,
            color: green,
            onTap: () => openCategory(context, 'التطبيقات'),
          ),
          const SizedBox(height: 15),
          CategoryTile(
            title: 'الاشتراكات',
            subtitle: 'Netflix • Shahid • Spotify',
            icon: Icons.workspace_premium,
            color: purple,
            onTap: () => openCategory(context, 'الاشتراكات'),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'AD STORE ©',
              style: TextStyle(
                color: Colors.white38,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openCategory(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(
          name: name,
          cart: cart,
          onCartChanged: onCartChanged,
        ),
      ),
    );
  }
}

// CATEGORY TILE

class CategoryTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withOpacity(.6)),
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: color.withOpacity(.13),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: color, size: 35),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: green),
          ],
        ),
      ),
    );
  }
}

// CATEGORY PAGE

class CategoryPage extends StatelessWidget {
  final String name;
  final List<Product> cart;
  final VoidCallback onCartChanged;

  const CategoryPage({
    super.key,
    required this.name,
    required this.cart,
    required this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = catalog[name]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    cart: cart,
                    onChanged: onCartChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: .76,
        ),
        itemBuilder: (context, index) {
          final product = items[index];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductPage(
                    product: product,
                    onAdd: () {
                      cart.add(product);
                      onCartChanged();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// PRODUCT CARD

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: purple.withOpacity(.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProductImage(product: product, size: 85),
            const SizedBox(height: 13),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                color: green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [green, purple],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'عرض المنتج',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PRODUCT DETAILS

class ProductPage extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductPage({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text('تفاصيل المنتج'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductImage(product: product, size: 145),
              const SizedBox(height: 25),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  color: green,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    onAdd();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تمت الإضافة إلى السلة'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('أضف إلى السلة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CART

class CartPage extends StatefulWidget {
  final List<Product> cart;
  final VoidCallback onChanged;

  const CartPage({
    super.key,
    required this.cart,
    required this.onChanged,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text('سلة المشتريات'),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'السلة فارغة',
                style: TextStyle(fontSize: 21),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...widget.cart.map((product) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        ProductImage(product: product, size: 55),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(color: green),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.cart.remove(product);
                            });
                            widget.onChanged();
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Text(
                  'المجموع: \$${widget.cart.fold<double>(0, (sum, p) => sum + (double.tryParse(p.price) ?? 0)).toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'الدفع غير مفعّل في النسخة التجريبية',
                        ),
                      ),
                    );
                  },
                  child: const Text('متابعة الطلب'),
                ),
              ],
            ),
    );
  }
}
