import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

// ================== EXTENSION ==================
extension StringCasingExtension on String {
  String toTitleCase() {
    return split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';

  void show(String text) {
    setState(() => output = text);
  }

  // ================== HEAL (IMMUTABLE) ==================
  void demoHeal() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);

    final healedHero = hero.copyWith(baseHp: hero.baseHp + 10);

    show([
      '=== Heal (Immutable) ===',
      'Sebelum: HP = ${hero.baseHp}',
      'Sesudah: HP = ${healedHero.baseHp}',
      '',
      'Catatan:',
      '- Object lama tidak berubah',
      '- copyWith() buat object baru',
    ].join('\n'));
  }

  // ================== INVENTORY ==================
  void demoInventory() {
    final inventory = {
      'Potion': 3,
      'Elixir': 1,
      'Gold': 120,
      'Gem': 2,
    };

    final formatted = inventory.entries
        .map((e) => '• ${e.key.padRight(10)} : ${e.value}')
        .join('\n');

    show([
      '=== Inventory ===',
      formatted,
      '',
      'Catatan:',
      '- Map = key-value',
      '- entries untuk looping',
    ].join('\n'));
  }

  // ================== VARIABLES ==================
  void demoVariablesAndNullSafety() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;

    String? guild;

    final guildName = guild ?? 'No Guild';
    final guildUpper = guildName.toUpperCase();

    final List<int?> potions = [1, null, 3];

    show([
      '=== Variables + Null Safety ===',
      'name (var): $name',
      'hp (final): $hp',
      'maxLevel (const): $maxLevel',
      'guild: $guild',
      'guildName (??): $guildName',
      'guildUpper (?.): $guildUpper',
      'potions: $potions',
    ].join('\n'));
  }

  // ================== FUNCTIONS ==================
  void demoFunctions() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      if (title == null) return 'Halo $name!';
      return 'Halo $title $name!';
    }

    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    int applyTwice(int value, int Function(int) f) {
      return f(f(value));
    }

    final resultAdd = add(2, 3);
    final hello1 = greet('Rani');
    final hello2 = greet('Rani', 'Mage');
    final spell1 = castSpell(spell: 'Fireball');
    final spell2 = castSpell(spell: 'Heal', manaCost: 5);
    final doubledTwice = applyTwice(3, (x) => x * 2);

    show([
      '=== Functions ===',
      'add(2,3) => $resultAdd',
      'greet => $hello1 / $hello2',
      'spell => $spell1 / $spell2',
      'applyTwice => $doubledTwice',
    ].join('\n'));
  }

  // ================== COLLECTIONS ==================
  void demoCollections() {
    final rng = Random();

    final monsters = ['slime king', 'goblin lord', 'dark wolf', 'fire dragon']
        .map((m) => m.toTitleCase())
        .toList();

    final strongNames = monsters.where((m) => m.length > 4).toList();
    final labeled = monsters.map((m) => 'Monster: $m').toList();

    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    final loot = {
      'gold': 120,
      'potion': 2,
      'gem': 1,
    };

    final level = rng.nextInt(5) + 1;
    final rewards = [
      '🎁 Daily Reward',
      if (level >= 3) '⭐ Bonus Reward',
      for (final item in loot.keys) '• $item',
    ];

    show([
      '=== Collections ===',
      'monsters: $monsters',
      'strongNames: $strongNames',
      'labeled: $labeled',
      'hits: $hits',
      'totalDamage: $totalDamage',
      '',
      'rewards:',
      ...rewards,
    ].join('\n'));
  }

  // ================== CLASS ==================
  void demoClasses() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);

    final json = {
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
    };

    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class ===',
      'hero: $hero',
      'power: ${hero.power}',
      'leveled: $leveled',
      '',
      'hero2: $hero2',
      'jobLabel: ${hero2.job.label}',
    ].join('\n'));
  }

  // ================== ASYNC QUEST ==================
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest...');

    try {
      final quest = await fetchQuest();
      show('Quest: $quest');
    } catch (e) {
      show('Error: $e');
    }
  }

  Future<String> fetchQuest() async {
    await Future.delayed(const Duration(seconds: 1));

    final rng = Random();
    if (rng.nextInt(5) == 0) {
      throw Exception('Server tidur 😴');
    }

    const quests = [
      'Kalahkan Goblin',
      'Cari Potion',
      'Lindungi desa',
      'Temukan Gem',
    ];

    return quests[rng.nextInt(quests.length)];
  }

  // ================== SHOP ==================
  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      'Sword',
      'Shield',
      'Potion',
      'Magic Scroll',
    ];
  }

  Future<void> demoShop() async {
    show('🛒 Loading shop...');

    final items = await fetchShopItems();

    show([
      '=== Shop ===',
      ...items.map((e) => '• $e'),
    ].join('\n'));
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Lab RPG')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: demoVariablesAndNullSafety, child: const Text('Variables')),
                ElevatedButton(onPressed: demoFunctions, child: const Text('Functions')),
                ElevatedButton(onPressed: demoCollections, child: const Text('Collections')),
                ElevatedButton(onPressed: demoClasses, child: const Text('Class')),
                ElevatedButton(onPressed: demoHeal, child: const Text('Heal')),
                ElevatedButton(onPressed: demoInventory, child: const Text('Inventory')),
                ElevatedButton(onPressed: () => demoAsyncAwait(), child: const Text('Quest')),
                ElevatedButton(onPressed: () => demoShop(), child: const Text('Shop')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(output),
              ),
            ),
          ],
        ),
      ),
    );
  }
}