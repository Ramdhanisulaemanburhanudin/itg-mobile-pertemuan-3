enum Job { warrior, mage, archer }

// ================== EXTENSION ==================
extension JobLabel on Job {
  String get label {
    switch (this) {
      case Job.warrior:
        return 'Warrior';
      case Job.mage:
        return 'Mage';
      case Job.archer:
        return 'Archer';
    }
  }
}

// ================== CLASS ==================
class HeroRpg {
  final String name;
  final Job job;
  final int baseHp;
  final int baseMp;

  const HeroRpg({
    required this.name,
    required this.job,
    required this.baseHp,
    required this.baseMp,
  });

  // ================== COPY WITH (IMMUTABLE) ==================
  HeroRpg copyWith({
    String? name,
    Job? job,
    int? baseHp,
    int? baseMp,
  }) {
    return HeroRpg(
      name: name ?? this.name,
      job: job ?? this.job,
      baseHp: baseHp ?? this.baseHp,
      baseMp: baseMp ?? this.baseMp,
    );
  }

  // ================== LEVEL UP ==================
  HeroRpg levelUp(int times) {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + (10 * times),
      baseMp: baseMp + (5 * times),
    );
  }

  // ================== GETTER ==================
  int get power => baseHp + baseMp;

  // ================== FROM JSON ==================
  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    return HeroRpg(
      name: json['name'],
      job: Job.values.firstWhere((e) => e.name == json['job']),
      baseHp: json['baseHp'],
      baseMp: json['baseMp'],
    );
  }

  @override
  String toString() {
    return '$name (${job.label}) | HP: $baseHp | MP: $baseMp';
  }
}