import 'package:flutter/material.dart';

void main() => runApp(const DiVaS());

const bg = Color(0xFF10131A);
const card = Color(0xFF202532);
const green = Color(0xFF39D98A);
const pink = Color(0xFFFF69B4);
const purple = Color(0xFFB99AFF);

String cash(double n) => 'USD ${n.toStringAsFixed(2)}';

Color sectionColor(String s) {
if (s == 'الألعاب') return pink;
if (s == 'الاشتراكات') return purple;
return green;
}

class Pack {
String name;
double price;
Pack(this.name, this.price);
}

class Product {
String name, section, image, field;
bool active;
List<Pack> packs;
Product(this.name, this.section, this.packs,
{this.image = '', this.field = 'ID', this.active = true});
}

class Payment {
String name, currency, account;
double rate;
bool active;
Payment(this.name, this.currency, this.account, this.rate,
{this.active = true});
}

class Deposit {
int id;
String method, reference, status;
double usd, local;
Deposit(this.id, this.method, this.reference,
this.usd, this.local, this.status);
}

class Order {
int id;
String name, pack, account, field, status;
double price;
Order(this.id, this.name, this.pack, this.account,
this.field, this.price, this.status);
}

class DiVaS extends StatelessWidget {
const DiVaS({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'DiVaS',
debugShowCheckedModeBanner: false,
theme: ThemeData(
useMaterial3: true,
brightness: Brightness.dark,
scaffoldBackgroundColor: bg,
colorScheme: const ColorScheme.dark(
primary: green,
secondary: pink,
surface: card,
),
appBarTheme: const AppBarTheme(
backgroundColor: bg,
centerTitle: true,
),
inputDecorationTheme: InputDecorationTheme(
filled: true,
fillColor: card,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
),
),
home: const Shop(),
);
}
}

class Shop extends StatefulWidget {
const Shop({super.key});

@override
State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
int page = 0, nextId = 1001;
double balance = 0;
String? section;
String banner = '';
String welcome = 'أهلاً وسهلاً بكم في موقعنا الرسمي';

final products = <Product>[
Product('Tami', 'التطبيقات', [
Pack('1000 كوينز', 5),
Pack('2500 كوينز', 10),
Pack('6000 كوينز', 20),
]),
Product('Junko', 'التطبيقات', [Pack('أساسية', 3)]),
Product('Pota Live', 'التطبيقات', [Pack('أساسية', 4)]),
Product('Zaffa Live', 'التطبيقات', [Pack('أساسية', 4)]),
Product('Ume', 'التطبيقات', [Pack('أساسية', 3)]),
Product('PUBG Mobile', 'الألعاب', [Pack('أساسية', 5)]),
Product('Free Fire', 'الألعاب', [Pack('أساسية', 3)]),
Product('جواكر', 'الألعاب', [Pack('أساسية', 2)]),
Product('بيلباردو', 'الألعاب', [Pack('أساسية', 2)]),
Product('Netflix', 'الاشتراكات', [Pack('اشتراك', 8)],
field: 'Email'),
Product('Shahid', 'الاشتراكات', [Pack('اشتراك', 6)],
field: 'Email'),
Product('Spotify Premium', 'الاشتراكات',
[Pack('اشتراك', 5)], field: 'Email'),
Product('YouTube Premium', 'الاشتراكات',
[Pack('اشتراك', 6)], field: 'Email'),
Product('Disney+', 'الاشتراكات', [Pack('اشتراك', 7)],
field: 'Email'),
Product('Canva Pro', 'الاشتراكات', [Pack('اشتراك', 5)],
field: 'Email'),
];

final payments = <Payment>[
Payment('زين كاش', 'IQD', '', 1400),
Payment('شام كاش', 'SYP', '', 12000),
];

final deposits = <Deposit>[];
final orders = <Order>[];

void alert(String s) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(s)),
);
}

Future<String?> textDialog(String title, String value) async {
final c = TextEditingController(text: value);
final result = await showDialog<String>(
context: context,
builder: (d) => AlertDialog(
title: Text(title),
content: TextField(
controller: c,
maxLines: 3,
decoration: const InputDecoration(
labelText: 'القيمة الجديدة',
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(d),
child: const Text('إلغاء'),
),
ElevatedButton(
onPressed: () => Navigator.pop(d, c.text.trim()),
child: const Text('حفظ'),
),
],
),
);
c.dispose();
return result;
}

Widget photo(String url, {double size = 70}) {
if (url.trim().isEmpty) {
return Icon(Icons.image_outlined, color: green, size: size * .55);
}
return Image.network(
url.trim(),
fit: BoxFit.cover,
width: double.infinity,
height: double.infinity,
errorBuilder: (_, error, stack) => Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.broken_image, color: pink),
const SizedBox(height: 4),
const Text('تعذر عرض الصورة',
style: TextStyle(fontSize: 10)),
],
),
);
}

Widget sectionButton(String title, IconData icon) {
final color = sectionColor(title);
return InkWell(
onTap: () => setState(() {
section = title;
page = 1;
}),
child: Container(
padding: const EdgeInsets.symmetric(
vertical: 23, horizontal: 5),
decoration: BoxDecoration(
color: color.withOpacity(.15),
border: Border.all(color: color),
borderRadius: BorderRadius.circular(18),
),
child: Column(
children: [
Icon(icon, color: color, size: 32),
const SizedBox(height: 9),
Text(title,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 13, fontWeight: FontWeight.bold)),
],
),
),
);
}

Widget home() {
return ListView(
padding: const EdgeInsets.all(15),
children: [
Container(
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
gradient: const LinearGradient(colors: [
Color(0xFF234237), Color(0xFF40243B)
]),
borderRadius: BorderRadius.circular(24),
border: Border.all(color: pink),
),
child: Column(
children: [
const Icon(Icons.workspace_premium,
color: pink, size: 58),
const Text('DiVaS',
style: TextStyle(
color: green,
fontSize: 40,
fontWeight: FontWeight.w900)),
const SizedBox(height: 12),
Text(welcome,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 18, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),
const Text('خدمات ✦ سرعة ✦ وأمان',
style: TextStyle(color: pink)),
],
),
),
const SizedBox(height: 16),
Container(
height: 155,
clipBehavior: Clip.antiAlias,
decoration: BoxDecoration(
color: card,
borderRadius: BorderRadius.circular(18),
),
child: banner.isEmpty
? const Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.add_photo_alternate,
color: pink, size: 45),
Text('صورة الصفحة الرئيسية'),
Text('أضف رابطها من لوحة الإدارة',
style: TextStyle(
color: Colors.white60, fontSize: 12)),
],
)
: photo(banner),
),
const SizedBox(height: 14),
Card(
child: ListTile(
leading: const Icon(
Icons.account_balance_wallet, color: green),
title: const Text('رصيد محفظتك بالدولار'),
subtitle: Text(cash(balance),
style: const TextStyle(
color: green, fontSize: 22)),
trailing: IconButton(
icon: const Icon(Icons.add_circle, color: pink),
onPressed: addDeposit,
),
onTap: () => setState(() => page = 2),
),
),
const SizedBox(height: 20),
const Text('أقسام المتجر',
style: TextStyle(
fontSize: 23, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),
Row(
children: [
Expanded(child: sectionButton(
'التطبيقات', Icons.smartphone)),
const SizedBox(width: 8),
Expanded(child: sectionButton(
'الألعاب', Icons.sports_esports)),
const SizedBox(width: 8),
Expanded(child: sectionButton(
'الاشتراكات', Icons.workspace_premium)),
],
),
const SizedBox(height: 20),
const Center(
child: Text('اضغط على القسم لعرض التطبيقات',
style: TextStyle(color: Colors.white60)),
),
],
);
}

Widget productTile(Product p) {
final color = sectionColor(p.section);
return InkWell(
onTap: () => openProduct(p),
child: Container(
decoration: BoxDecoration(
color: card,
border: Border.all(color: color.withOpacity(.65)),
borderRadius: BorderRadius.circular(17),
),
child: Column(
children: [
Expanded(
child: Padding(
padding: const EdgeInsets.all(9),
child: ClipRRect(
borderRadius: BorderRadius.circular(12),
child: SizedBox(
width: double.infinity,
child: Center(child: photo(p.image)),
),
),
),
),
Padding(
padding: const EdgeInsets.only(bottom: 12),
child: Text(p.name,
maxLines: 2,
textAlign: TextAlign.center,
style: const TextStyle(
fontWeight: FontWeight.bold)),
),
],
),
),
);
}

Widget catalog() {
if (section == null) {
return ListView(
padding: const EdgeInsets.all(18),
children: [
const Text('اختر القسم',
style: TextStyle(fontSize: 23)),
const SizedBox(height: 14),
sectionButton('التطبيقات', Icons.smartphone),
const SizedBox(height: 12),
sectionButton('الألعاب', Icons.sports_esports),
const SizedBox(height: 12),
sectionButton('الاشتراكات', Icons.workspace_premium),
],
);
}

final shown = products  
    .where((p) => p.active && p.section == section)  
    .toList();  

return Column(  
  children: [  
    ListTile(  
      leading: IconButton(  
        icon: const Icon(Icons.arrow_back),  
        onPressed: () => setState(() => section = null),  
      ),  
      title: Text(section!,  
          style: TextStyle(  
              color: sectionColor(section!),  
              fontSize: 22,  
              fontWeight: FontWeight.bold)),  
    ),  
    Expanded(  
      child: GridView.builder(  
        padding: const EdgeInsets.all(12),  
        itemCount: shown.length,  
        gridDelegate:  
            const SliverGridDelegateWithFixedCrossAxisCount(  
          crossAxisCount: 2,  
          childAspectRatio: .9,  
          crossAxisSpacing: 12,  
          mainAxisSpacing: 12,  
        ),  
        itemBuilder: (_, i) => productTile(shown[i]),  
      ),  
    ),  
  ],  
);

}

void openProduct(Product p) {
if (p.packs.isEmpty) {
alert('لا توجد باقات لهذا المنتج');
return;
}

Pack selected = p.packs.first;  
final account = TextEditingController();  

showDialog(  
  context: context,  
  builder: (d) => StatefulBuilder(  
    builder: (d, refresh) => AlertDialog(  
      title: Text('شحن ${p.name}'),  
      content: SingleChildScrollView(  
        child: Column(  
          mainAxisSize: MainAxisSize.min,  
          children: [  
            SizedBox(  
              height: 95,  
              width: 95,  
              child: photo(p.image),  
            ),  
            const SizedBox(height: 15),  
            DropdownButtonFormField<Pack>(  
              value: selected,  
              isExpanded: true,  
              decoration: const InputDecoration(  
                  labelText: 'اختر باقة واحدة'),  
              items: p.packs.map((pack) {  
                return DropdownMenuItem(  
                  value: pack,  
                  child: Text(  
                      '${pack.name} - ${cash(pack.price)}'),  
                );  
              }).toList(),  
              onChanged: (v) {  
                if (v != null) refresh(() => selected = v);  
              },  
            ),  
            const SizedBox(height: 14),  
            TextField(  
              controller: account,  
              keyboardType: p.field == 'Email'  
                  ? TextInputType.emailAddress  
                  : TextInputType.text,  
              decoration: InputDecoration(  
                labelText: p.field == 'Email'  
                    ? 'البريد الإلكتروني'  
                    : 'آيدي الحساب (ID)',  
              ),  
            ),  
            const SizedBox(height: 15),  
            Text('السعر: ${cash(selected.price)}',  
                style: const TextStyle(  
                    color: green, fontSize: 20)),  
            Text('رصيدك: ${cash(balance)}'),  
          ],  
        ),  
      ),  
      actions: [  
        TextButton(  
          onPressed: () => Navigator.pop(d),  
          child: const Text('إلغاء'),  
        ),  
        ElevatedButton(  
          onPressed: () {  
            final value = account.text.trim();  
            if (value.isEmpty) {  
              alert('أدخل بيانات الحساب');  
              return;  
            }  
            if (p.field == 'Email' &&  
                !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')  
                    .hasMatch(value)) {  
              alert('أدخل بريداً إلكترونياً صحيحاً');  
              return;  
            }  
            if (balance < selected.price) {  
              alert('رصيدك غير كافٍ');  
              return;  
            }  
            setState(() {  
              balance -= selected.price;  
              orders.insert(  
                0,  
                Order(  
                  nextId++,  
                  p.name,  
                  selected.name,  
                  value,  
                  p.field,  
                  selected.price,  
                  'قيد الانتظار',  
                ),  
              );  
            });  
            Navigator.pop(d);  
            alert('تم تسجيل طلب الشحن');  
          },  
          child: const Text('تأكيد الشحن'),  
        ),  
      ],  
    ),  
  ),  
).then((_) => account.dispose());

}

void addDeposit() {
final active = payments.where((p) => p.active).toList();
if (active.isEmpty) {
alert('لا توجد طرق دفع متاحة');
return;
}

Payment selected = active.first;  
final amount = TextEditingController();  
final reference = TextEditingController();  

showDialog(  
  context: context,  
  builder: (d) => StatefulBuilder(  
    builder: (d, refresh) {  
      final value = double.tryParse(amount.text) ?? 0;  
      final local = value * selected.rate;  

      return AlertDialog(  
        title: const Text('طلب إضافة رصيد'),  
        content: SingleChildScrollView(  
          child: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: [  
              TextField(  
                controller: amount,  
                keyboardType:  
                    const TextInputType.numberWithOptions(  
                        decimal: true),  
                decoration: const InputDecoration(  
                    labelText: 'المبلغ بالدولار USD'),  
                onChanged: (_) => refresh(() {}),  
              ),  
              const SizedBox(height: 12),  
              DropdownButtonFormField<Payment>(  
                value: selected,  
                isExpanded: true,  
                decoration: const InputDecoration(  
                    labelText: 'طريقة إضافة الرصيد'),  
                items: active.map((m) {  
                  return DropdownMenuItem(  
                    value: m,  
                    child: Text(m.name),  
                  );  
                }).toList(),  
                onChanged: (v) {  
                  if (v != null) refresh(() => selected = v);  
                },  
              ),  
              const SizedBox(height: 14),  
              Text(  
                '1 USD = ${selected.rate} '  
                '${selected.currency}',  
              ),  
              const SizedBox(height: 8),  
              Text(  
                'المطلوب تحويله: '  
                '${local.toStringAsFixed(2)} '  
                '${selected.currency}',  
                style: const TextStyle(  
                    color: green, fontSize: 18),  
              ),  
              const SizedBox(height: 12),  
              SelectableText(  
                selected.account.isEmpty  
                    ? 'لم تحدد الإدارة حساب الدفع'  
                    : 'حساب الدفع:\n${selected.account}',  
                textAlign: TextAlign.center,  
              ),  
              const SizedBox(height: 12),  
              TextField(  
                controller: reference,  
                decoration: const InputDecoration(  
                    labelText: 'رقم عملية التحويل'),  
              ),  
              const SizedBox(height: 10),  
              const Text(  
                'لن تتم إضافة الرصيد إلا بعد '  
                'مراجعة الإدارة والموافقة.',  
                style: TextStyle(fontSize: 12),  
              ),  
            ],  
          ),  
        ),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.pop(d),  
            child: const Text('إلغاء'),  
          ),  
          ElevatedButton(  
            onPressed: () {  
              if (!value.isFinite ||  
                  value <= 0 ||  
                  !local.isFinite ||  
                  selected.account.trim().isEmpty ||  
                  reference.text.trim().isEmpty) {  
                alert('أكمل البيانات وتأكد من حساب الدفع');  
                return;  
              }  
              setState(() {  
                deposits.insert(  
                  0,  
                  Deposit(  
                    nextId++,  
                    selected.name,  
                    reference.text.trim(),  
                    value,  
                    local,  
                    'قيد المراجعة',  
                  ),  
                );  
              });  
              Navigator.pop(d);  
              alert('تم تسجيل طلب الإيداع للمراجعة');  
            },  
            child: const Text('إرسال الطلب'),  
          ),  
        ],  
      );  
    },  
  ),  
).then((_) {  
  amount.dispose();  
  reference.dispose();  
});

}

Widget wallet() {
return ListView(
padding: const EdgeInsets.all(16),
children: [
const Icon(Icons.account_balance_wallet,
color: pink, size: 55),
const SizedBox(height: 12),
const Text('محفظة DiVaS',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 25)),
Card(
child: Padding(
padding: const EdgeInsets.all(24),
child: Column(
children: [
const Text('رصيدك بالدولار'),
const SizedBox(height: 10),
Text(cash(balance),
style: const TextStyle(
color: green,
fontSize: 36,
fontWeight: FontWeight.bold)),
],
),
),
),
const SizedBox(height: 12),
ElevatedButton.icon(
onPressed: addDeposit,
icon: const Icon(Icons.add),
label: const Text('إضافة رصيد'),
),
const SizedBox(height: 20),
const Text('طلبات الإيداع',
style: TextStyle(fontSize: 20)),
if (deposits.isEmpty)
const ListTile(title: Text('لا توجد طلبات')),
for (final d in deposits)
Card(
child: ListTile(
title: Text('طلب #${d.id} - ${cash(d.usd)}'),
subtitle: Text(
'${d.method}\nالحالة: ${d.status}'),
),
),
],
);
}

Widget myOrders() {
return ListView(
padding: const EdgeInsets.all(16),
children: [
const Text('طلبات الشحن',
style: TextStyle(fontSize: 23)),
if (orders.isEmpty)
const ListTile(title: Text('لا توجد طلبات بعد')),
for (final o in orders)
Card(
child: ListTile(
title: Text('#${o.id} - ${o.name}'),
subtitle: Text(
'${o.pack}\n'
'${o.field}: ${o.account}\n'
'الحالة: ${o.status}',
),
isThreeLine: true,
trailing: Text(cash(o.price),
style: const TextStyle(color: green)),
),
),
],
);
}

Future<void> editProduct([Product? p]) async {
final name = TextEditingController(text: p?.name ?? '');
final image = TextEditingController(text: p?.image ?? '');
String cat = p?.section ?? 'التطبيقات';
String field = p?.field ?? 'ID';
bool active = p?.active ?? true;
final packs = p == null
? <Pack>[]
: p.packs.map((e) => Pack(e.name, e.price)).toList();

final save = await showDialog<bool>(  
  context: context,  
  builder: (d) => StatefulBuilder(  
    builder: (d, refresh) => AlertDialog(  
      title: Text(p == null ? 'إضافة تطبيق' : 'تعديل التطبيق'),  
      content: SizedBox(  
        width: 350,  
        child: SingleChildScrollView(  
          child: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: [  
              TextField(  
                controller: name,  
                decoration: const InputDecoration(  
                    labelText: 'اسم التطبيق'),  
              ),  
              const SizedBox(height: 10),  
              TextField(  
                controller: image,  
                decoration: const InputDecoration(  
                    labelText: 'رابط الصورة المباشر'),  
              ),  
              const SizedBox(height: 10),  
              DropdownButtonFormField<String>(  
                value: cat,  
                decoration: const InputDecoration(  
                    labelText: 'القسم'),  
                items: ['التطبيقات', 'الألعاب', 'الاشتراكات']  
                    .map((s) => DropdownMenuItem(  
                        value: s, child: Text(s)))  
                    .toList(),  
                onChanged: (v) {  
                  if (v != null) refresh(() => cat = v);  
                },  
              ),  
              const SizedBox(height: 10),  
              DropdownButtonFormField<String>(  
                value: field,  
                decoration: const InputDecoration(  
                    labelText: 'حقل الشحن'),  
                items: ['ID', 'Email']  
                    .map((s) => DropdownMenuItem(  
                        value: s, child: Text(s)))  
                    .toList(),  
                onChanged: (v) {  
                  if (v != null) refresh(() => field = v);  
                },  
              ),  
              SwitchListTile(  
                title: const Text('مفعّل'),  
                value: active,  
                onChanged: (v) => refresh(() => active = v),  
              ),  
              const Divider(),  
              const Text('الباقات والأسعار'),  
              for (int i = 0; i < packs.length; i++)  
                ListTile(  
                  title: Text(packs[i].name),  
                  subtitle: Text(cash(packs[i].price)),  
                  trailing: IconButton(  
                    icon: const Icon(Icons.delete, color: pink),  
                    onPressed: () =>  
                        refresh(() => packs.removeAt(i)),  
                  ),  
                  onTap: () async {  
                    final changed = await packEditor(packs[i]);  
                    if (changed != null) {  
                      refresh(() => packs[i] = changed);  
                    }  
                  },  
                ),  
              OutlinedButton.icon(  
                onPressed: () async {  
                  final result = await packEditor();  
                  if (result != null) {  
                    refresh(() => packs.add(result));  
                  }  
                },  
                icon: const Icon(Icons.add),  
                label: const Text('إضافة باقة'),  
              ),  
            ],  
          ),  
        ),  
      ),  
      actions: [  
        TextButton(  
          onPressed: () => Navigator.pop(d, false),  
          child: const Text('إلغاء'),  
        ),  
        ElevatedButton(  
          onPressed: () {  
            if (name.text.trim().isEmpty || packs.isEmpty) {  
              alert('أدخل اسم المنتج وباقة واحدة على الأقل');  
              return;  
            }  
            Navigator.pop(d, true);  
          },  
          child: const Text('حفظ'),  
        ),  
      ],  
    ),  
  ),  
);  

if (save == true && mounted) {  
  setState(() {  
    if (p == null) {  
      products.add(Product(  
        name.text.trim(), cat, packs,  
        image: image.text.trim(),  
        field: field,  
        active: active,  
      ));  
    } else {  
      p.name = name.text.trim();  
      p.section = cat;  
      p.image = image.text.trim();  
      p.field = field;  
      p.active = active;  
      p.packs = packs;  
    }  
  });  
}  
name.dispose();  
image.dispose();

}

Future<Pack?> packEditor([Pack? old]) async {
final name = TextEditingController(text: old?.name ?? '');
final price = TextEditingController(
text: old?.price.toString() ?? '');

final result = await showDialog<Pack>(  
  context: context,  
  builder: (d) => AlertDialog(  
    title: const Text('الباقة والسعر'),  
    content: Column(  
      mainAxisSize: MainAxisSize.min,  
      children: [  
        TextField(  
          controller: name,  
          decoration: const InputDecoration(  
              labelText: 'اسم الباقة'),  
        ),  
        const SizedBox(height: 10),  
        TextField(  
          controller: price,  
          keyboardType: const TextInputType.numberWithOptions(  
              decimal: true),  
          decoration: const InputDecoration(  
              labelText: 'السعر بالدولار'),  
        ),  
      ],  
    ),  
    actions: [  
      TextButton(  
        onPressed: () => Navigator.pop(d),  
        child: const Text('إلغاء'),  
      ),  
      ElevatedButton(  
        onPressed: () {  
          final value = double.tryParse(price.text);  
          if (name.text.trim().isEmpty ||  
              value == null ||  
              !value.isFinite ||  
              value <= 0) {  
            alert('أدخل باقة وسعراً صحيحاً');  
            return;  
          }  
          Navigator.pop(d, Pack(name.text.trim(), value));  
        },  
        child: const Text('حفظ'),  
      ),  
    ],  
  ),  
);  

name.dispose();  
price.dispose();  
return result;

}

Future<void> editPayment([Payment? p]) async {
final name = TextEditingController(text: p?.name ?? '');
final currency =
TextEditingController(text: p?.currency ?? '');
final account =
TextEditingController(text: p?.account ?? '');
final rate =
TextEditingController(text: p?.rate.toString() ?? '');
bool active = p?.active ?? true;

final save = await showDialog<bool>(  
  context: context,  
  builder: (d) => StatefulBuilder(  
    builder: (d, refresh) => AlertDialog(  
      title: const Text('إعدادات طريقة الدفع'),  
      content: SingleChildScrollView(  
        child: Column(  
          mainAxisSize: MainAxisSize.min,  
          children: [  
            TextField(  
              controller: name,  
              decoration: const InputDecoration(  
                  labelText: 'اسم الطريقة'),  
            ),  
            const SizedBox(height: 10),  
            TextField(  
              controller: currency,  
              decoration: const InputDecoration(  
                  labelText: 'العملة، مثال IQD'),  
            ),  
            const SizedBox(height: 10),  
            TextField(  
              controller: account,  
              maxLines: 2,  
              decoration: const InputDecoration(  
                  labelText: 'رقم حساب التحويل'),  
            ),  
            const SizedBox(height: 10),  
            TextField(  
              controller: rate,  
              keyboardType:  
                  const TextInputType.numberWithOptions(  
                      decimal: true),  
              decoration: const InputDecoration(  
                  labelText: 'كم تساوي 1 USD؟'),  
            ),  
            SwitchListTile(  
              title: const Text('مفعّلة'),  
              value: active,  
              onChanged: (v) => refresh(() => active = v),  
            ),  
          ],  
        ),  
      ),  
      actions: [  
        TextButton(  
          onPressed: () => Navigator.pop(d, false),  
          child: const Text('إلغاء'),  
        ),  
        ElevatedButton(  
          onPressed: () {  
            final value = double.tryParse(rate.text);  
            if (name.text.trim().isEmpty ||  
                currency.text.trim().isEmpty ||  
                value == null ||  
                !value.isFinite ||  
                value <= 0) {  
              alert('أدخل بيانات صحيحة');  
              return;  
            }  
            Navigator.pop(d, true);  
          },  
          child: const Text('حفظ'),  
        ),  
      ],  
    ),  
  ),  
);  

if (save == true && mounted) {  
  final value = double.parse(rate.text);  
  setState(() {  
    if (p == null) {  
      payments.add(Payment(  
        name.text.trim(),  
        currency.text.trim(),  
        account.text.trim(),  
        value,  
        active: active,  
      ));  
    } else {  
      p.name = name.text.trim();  
      p.currency = currency.text.trim();  
      p.account = account.text.trim();  
      p.rate = value;  
      p.active = active;  
    }  
  });  
}  

name.dispose();  
currency.dispose();  
account.dispose();  
rate.dispose();

}

Widget admin() {
return ListView(
padding: const EdgeInsets.all(15),
children: [
const Icon(Icons.workspace_premium,
color: pink, size: 48),
const Text(
'DiVaS ADMIN',
textAlign: TextAlign.center,
style: TextStyle(
color: green,
fontSize: 25,
fontWeight: FontWeight.bold),
),
const SizedBox(height: 10),
const Card(
child: Padding(
padding: EdgeInsets.all(12),
child: Text(
'لوحة تجريبية غير محمية. '
'لا تنشرها للزبائن قبل ربط تسجيل دخول آمن.',
style: TextStyle(color: pink),
),
),
),
const SizedBox(height: 15),
const Text('صور الموقع',
style: TextStyle(fontSize: 21)),
Card(
child: ListTile(
leading: const Icon(Icons.wallpaper, color: green),
title: const Text('صورة الصفحة الرئيسية'),
subtitle: Text(
banner.isEmpty ? 'لم تضف صورة' : banner,
maxLines: 2),
trailing: const Icon(Icons.edit, color: pink),
onTap: () async {
final v = await textDialog(
'رابط صورة الرئيسية', banner);
if (v != null && mounted) {
setState(() => banner = v);
}
},
),
),
Card(
child: ListTile(
leading: const Icon(Icons.edit_note, color: green),
title: const Text('رسالة الترحيب'),
subtitle: Text(welcome),
onTap: () async {
final v = await textDialog(
'رسالة الترحيب', welcome);
if (v != null && v.isNotEmpty && mounted) {
setState(() => welcome = v);
}
},
),
),
const Divider(height: 30),
const Text('طلبات إضافة الرصيد',
style: TextStyle(fontSize: 21)),
if (deposits.isEmpty)
const ListTile(title: Text('لا توجد طلبات')),
for (final d in deposits)
Card(
child: Column(
children: [
ListTile(
title: Text('#${d.id} - ${cash(d.usd)}'),
subtitle: Text(
'${d.method}\n'
'رقم العملية: ${d.reference}\n'
'الحالة: ${d.status}',
),
),
if (d.status == 'قيد المراجعة')
Wrap(
spacing: 8,
children: [
ElevatedButton(
onPressed: () {
if (d.status != 'قيد المراجعة') return;
setState(() {
d.status = 'مقبول';
balance += d.usd;
});
alert('تمت إضافة الرصيد');
},
child: const Text('موافقة وإضافة'),
),
OutlinedButton(
onPressed: () {
setState(() => d.status = 'مرفوض');
},
child: const Text('رفض'),
),
],
),
],
),
),
const Divider(height: 30),
const Text('طلبات الشحن',
style: TextStyle(fontSize: 21)),
for (final o in orders)
Card(
child: Column(
children: [
ListTile(
title: Text('#${o.id} - ${o.name}'),
subtitle: Text(
'${o.pack}\n'
'${o.field}: ${o.account}\n'
'${cash(o.price)}',
),
),
Padding(
padding: const EdgeInsets.all(8),
child: DropdownButtonFormField<String>(
value: o.status,
decoration: const InputDecoration(
labelText: 'حالة الطلب'),
items: [
'قيد الانتظار',
'قيد التنفيذ',
'تم الشحن',
'ملغي'
].map((s) => DropdownMenuItem(
value: s,
child: Text(s),
)).toList(),
onChanged: (v) {
if (v != null) {
setState(() => o.status = v);
}
},
),
),
],
),
),
const Divider(height: 30),
Row(
children: [
const Expanded(
child: Text('إدارة التطبيقات',
style: TextStyle(fontSize: 21)),
),
ElevatedButton(
onPressed: () => editProduct(),
child: const Text('إضافة'),
),
],
),
for (final p in products)
Card(
child: ListTile(
title: Text(p.name),
subtitle: Text(
'${p.section} • ${p.field} • '
'${p.active ? "مفعّل" : "متوقف"}',
),
trailing: const Icon(Icons.edit, color: pink),
onTap: () => editProduct(p),
),
),
const Divider(height: 30),
Row(
children: [
const Expanded(
child: Text('طرق إضافة الرصيد',
style: TextStyle(fontSize: 21)),
),
ElevatedButton(
onPressed: () => editPayment(),
child: const Text('إضافة'),
),
],
),
for (final p in payments)
Card(
child: ListTile(
title: Text(p.name),
subtitle: Text(
'1 USD = ${p.rate} ${p.currency}\n'
'${p.account.isEmpty ? "الحساب غير محدد" : p.account}\n'
'${p.active ? "مفعّلة" : "متوقفة"}',
),
trailing: const Icon(Icons.edit, color: pink),
onTap: () => editPayment(p),
),
),
const SizedBox(height: 25),
],
);
}

@override
Widget build(BuildContext context) {
final pages = [
home(),
catalog(),
wallet(),
myOrders(),
admin(),
];

return Directionality(  
  textDirection: TextDirection.rtl,  
  child: Scaffold(  
    appBar: AppBar(  
      title: const Row(  
        mainAxisSize: MainAxisSize.min,  
        children: [  
          Icon(Icons.workspace_premium, color: pink),  
          SizedBox(width: 8),  
          Text('DiVaS',  
              style: TextStyle(  
                  color: green,  
                  fontWeight: FontWeight.w900)),  
        ],  
      ),  
    ),  
    body: pages[page],  
    bottomNavigationBar: NavigationBar(  
      selectedIndex: page,  
      backgroundColor: card,  
      labelBehavior:  
          NavigationDestinationLabelBehavior.alwaysShow,  
      onDestinationSelected: (v) {  
        setState(() => page = v);  
      },  
      destinations: const [  
        NavigationDestination(  
            icon: Icon(Icons.home), label: 'الرئيسية'),  
        NavigationDestination(  
            icon: Icon(Icons.apps), label: 'الأقسام'),  
        NavigationDestination(  
            icon: Icon(Icons.account_balance_wallet),  
            label: 'المحفظة'),  
        NavigationDestination(  
            icon: Icon(Icons.receipt_long),  
            label: 'طلباتي'),  
        NavigationDestination(  
            icon: Icon(Icons.settings), label: 'الإدارة'),  
      ],  
    ),  
  ),  
);

}
}
