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
      type: DriftSqlType.int, requiredDuringInsert: false);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PokemonTableTable pokemonTable = $PokemonTableTable(this);
  late final $PokemonTypeTableTable pokemonTypeTable =
      $PokemonTypeTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pokemonTable, pokemonTypeTable];
}
