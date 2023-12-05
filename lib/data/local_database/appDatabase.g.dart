// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appDatabase.dart';

// ignore_for_file: type=lint
class $PokemonTableTable extends PokemonTable
    with TableInfo<$PokemonTableTable, PokemonEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraInfoUrlMeta =
      const VerificationMeta('extraInfoUrl');
  @override
  late final GeneratedColumn<String> extraInfoUrl = GeneratedColumn<String>(
      'extra_info_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, extraInfoUrl, order, photoUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_table';
  @override
  VerificationContext validateIntegrity(Insertable<PokemonEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('extra_info_url')) {
      context.handle(
          _extraInfoUrlMeta,
          extraInfoUrl.isAcceptableOrUnknown(
              data['extra_info_url']!, _extraInfoUrlMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      extraInfoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra_info_url']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order']),
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
    );
  }

  @override
  $PokemonTableTable createAlias(String alias) {
    return $PokemonTableTable(attachedDatabase, alias);
  }
}

class PokemonTableCompanion extends UpdateCompanion<PokemonEntity> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> extraInfoUrl;
  final Value<int?> order;
  final Value<String?> photoUrl;
  const PokemonTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.extraInfoUrl = const Value.absent(),
    this.order = const Value.absent(),
    this.photoUrl = const Value.absent(),
  });
  PokemonTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.extraInfoUrl = const Value.absent(),
    this.order = const Value.absent(),
    this.photoUrl = const Value.absent(),
  });
  static Insertable<PokemonEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? extraInfoUrl,
    Expression<int>? order,
    Expression<String>? photoUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (extraInfoUrl != null) 'extra_info_url': extraInfoUrl,
      if (order != null) 'order': order,
      if (photoUrl != null) 'photo_url': photoUrl,
    });
  }

  PokemonTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? extraInfoUrl,
      Value<int?>? order,
      Value<String?>? photoUrl}) {
    return PokemonTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      extraInfoUrl: extraInfoUrl ?? this.extraInfoUrl,
      order: order ?? this.order,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (extraInfoUrl.present) {
      map['extra_info_url'] = Variable<String>(extraInfoUrl.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('extraInfoUrl: $extraInfoUrl, ')
          ..write('order: $order, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypeTableTable extends PokemonTypeTable
    with TableInfo<$PokemonTypeTableTable, PokemonTypeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_type_table';
  @override
  VerificationContext validateIntegrity(Insertable<PokemonTypeEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonTypeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $PokemonTypeTableTable createAlias(String alias) {
    return $PokemonTypeTableTable(attachedDatabase, alias);
  }
}

class PokemonTypeTableCompanion extends UpdateCompanion<PokemonTypeEntity> {
  final Value<int> id;
  final Value<String?> name;
  const PokemonTypeTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PokemonTypeTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<PokemonTypeEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PokemonTypeTableCompanion copyWith({Value<int>? id, Value<String?>? name}) {
    return PokemonTypeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PokemonWithPokemonTypeTableTable extends PokemonWithPokemonTypeTable
    with
        TableInfo<$PokemonWithPokemonTypeTableTable,
            PokemonWithPokemonTypeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonWithPokemonTypeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pokemonIdMeta =
      const VerificationMeta('pokemonId');
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
      'pokemon_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pokemon_table (id)'));
  static const VerificationMeta _pokemonTypeIdMeta =
      const VerificationMeta('pokemonTypeId');
  @override
  late final GeneratedColumn<int> pokemonTypeId = GeneratedColumn<int>(
      'pokemon_type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pokemon_type_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, pokemonId, pokemonTypeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_with_pokemon_type_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PokemonWithPokemonTypeEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(_pokemonIdMeta,
          pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta));
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('pokemon_type_id')) {
      context.handle(
          _pokemonTypeIdMeta,
          pokemonTypeId.isAcceptableOrUnknown(
              data['pokemon_type_id']!, _pokemonTypeIdMeta));
    } else if (isInserting) {
      context.missing(_pokemonTypeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonWithPokemonTypeEntity map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonWithPokemonTypeEntity(
      pokemonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pokemon_id'])!,
      pokemonTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pokemon_type_id'])!,
    );
  }

  @override
  $PokemonWithPokemonTypeTableTable createAlias(String alias) {
    return $PokemonWithPokemonTypeTableTable(attachedDatabase, alias);
  }
}

class PokemonWithPokemonTypeTableCompanion
    extends UpdateCompanion<PokemonWithPokemonTypeEntity> {
  final Value<int> id;
  final Value<int> pokemonId;
  final Value<int> pokemonTypeId;
  const PokemonWithPokemonTypeTableCompanion({
    this.id = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.pokemonTypeId = const Value.absent(),
  });
  PokemonWithPokemonTypeTableCompanion.insert({
    this.id = const Value.absent(),
    required int pokemonId,
    required int pokemonTypeId,
  })  : pokemonId = Value(pokemonId),
        pokemonTypeId = Value(pokemonTypeId);
  static Insertable<PokemonWithPokemonTypeEntity> custom({
    Expression<int>? id,
    Expression<int>? pokemonId,
    Expression<int>? pokemonTypeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (pokemonTypeId != null) 'pokemon_type_id': pokemonTypeId,
    });
  }

  PokemonWithPokemonTypeTableCompanion copyWith(
      {Value<int>? id, Value<int>? pokemonId, Value<int>? pokemonTypeId}) {
    return PokemonWithPokemonTypeTableCompanion(
      id: id ?? this.id,
      pokemonId: pokemonId ?? this.pokemonId,
      pokemonTypeId: pokemonTypeId ?? this.pokemonTypeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (pokemonTypeId.present) {
      map['pokemon_type_id'] = Variable<int>(pokemonTypeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonWithPokemonTypeTableCompanion(')
          ..write('id: $id, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('pokemonTypeId: $pokemonTypeId')
          ..write(')'))
        .toString();
  }
}

class $StatsTableTable extends StatsTable
    with TableInfo<$StatsTableTable, StatsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _baseStatMeta =
      const VerificationMeta('baseStat');
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
      'base_stat', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, baseStat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats_table';
  @override
  VerificationContext validateIntegrity(Insertable<StatsEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('base_stat')) {
      context.handle(_baseStatMeta,
          baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  StatsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatsEntity(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      baseStat: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_stat']),
    );
  }

  @override
  $StatsTableTable createAlias(String alias) {
    return $StatsTableTable(attachedDatabase, alias);
  }
}

class StatsTableCompanion extends UpdateCompanion<StatsEntity> {
  final Value<String?> name;
  final Value<int?> baseStat;
  final Value<int> rowid;
  const StatsTableCompanion({
    this.name = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StatsTableCompanion.insert({
    this.name = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<StatsEntity> custom({
    Expression<String>? name,
    Expression<int>? baseStat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (baseStat != null) 'base_stat': baseStat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StatsTableCompanion copyWith(
      {Value<String?>? name, Value<int?>? baseStat, Value<int>? rowid}) {
    return StatsTableCompanion(
      name: name ?? this.name,
      baseStat: baseStat ?? this.baseStat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsTableCompanion(')
          ..write('name: $name, ')
          ..write('baseStat: $baseStat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonWithStatsTableTable extends PokemonWithStatsTable
    with TableInfo<$PokemonWithStatsTableTable, PokemonWithStatsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonWithStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statNameMeta =
      const VerificationMeta('statName');
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
      'stat_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pokemonIdMeta =
      const VerificationMeta('pokemonId');
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
      'pokemon_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, statName, pokemonId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_with_stats_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PokemonWithStatsEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stat_name')) {
      context.handle(_statNameMeta,
          statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta));
    } else if (isInserting) {
      context.missing(_statNameMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(_pokemonIdMeta,
          pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta));
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonWithStatsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonWithStatsEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_name'])!,
      pokemonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pokemon_id'])!,
    );
  }

  @override
  $PokemonWithStatsTableTable createAlias(String alias) {
    return $PokemonWithStatsTableTable(attachedDatabase, alias);
  }
}

class PokemonWithStatsTableCompanion
    extends UpdateCompanion<PokemonWithStatsEntity> {
  final Value<int> id;
  final Value<String> statName;
  final Value<int> pokemonId;
  const PokemonWithStatsTableCompanion({
    this.id = const Value.absent(),
    this.statName = const Value.absent(),
    this.pokemonId = const Value.absent(),
  });
  PokemonWithStatsTableCompanion.insert({
    this.id = const Value.absent(),
    required String statName,
    required int pokemonId,
  })  : statName = Value(statName),
        pokemonId = Value(pokemonId);
  static Insertable<PokemonWithStatsEntity> custom({
    Expression<int>? id,
    Expression<String>? statName,
    Expression<int>? pokemonId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statName != null) 'stat_name': statName,
      if (pokemonId != null) 'pokemon_id': pokemonId,
    });
  }

  PokemonWithStatsTableCompanion copyWith(
      {Value<int>? id, Value<String>? statName, Value<int>? pokemonId}) {
    return PokemonWithStatsTableCompanion(
      id: id ?? this.id,
      statName: statName ?? this.statName,
      pokemonId: pokemonId ?? this.pokemonId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonWithStatsTableCompanion(')
          ..write('id: $id, ')
          ..write('statName: $statName, ')
          ..write('pokemonId: $pokemonId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PokemonTableTable pokemonTable = $PokemonTableTable(this);
  late final $PokemonTypeTableTable pokemonTypeTable =
      $PokemonTypeTableTable(this);
  late final $PokemonWithPokemonTypeTableTable pokemonWithPokemonTypeTable =
      $PokemonWithPokemonTypeTableTable(this);
  late final $StatsTableTable statsTable = $StatsTableTable(this);
  late final $PokemonWithStatsTableTable pokemonWithStatsTable =
      $PokemonWithStatsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        pokemonTable,
        pokemonTypeTable,
        pokemonWithPokemonTypeTable,
        statsTable,
        pokemonWithStatsTable
      ];
}
