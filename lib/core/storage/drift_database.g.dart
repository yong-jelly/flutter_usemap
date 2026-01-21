// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $OfflineQueueTable extends OfflineQueue
    with TableInfo<$OfflineQueueTable, OfflineQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isProcessedMeta = const VerificationMeta(
    'isProcessed',
  );
  @override
  late final GeneratedColumn<bool> isProcessed = GeneratedColumn<bool>(
    'is_processed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_processed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    payload,
    createdAt,
    isProcessed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflineQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_processed')) {
      context.handle(
        _isProcessedMeta,
        isProcessed.isAcceptableOrUnknown(
          data['is_processed']!,
          _isProcessedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isProcessed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_processed'],
      )!,
    );
  }

  @override
  $OfflineQueueTable createAlias(String alias) {
    return $OfflineQueueTable(attachedDatabase, alias);
  }
}

class OfflineQueueData extends DataClass
    implements Insertable<OfflineQueueData> {
  final int id;
  final String action;
  final String payload;
  final DateTime createdAt;
  final bool isProcessed;
  const OfflineQueueData({
    required this.id,
    required this.action,
    required this.payload,
    required this.createdAt,
    required this.isProcessed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_processed'] = Variable<bool>(isProcessed);
    return map;
  }

  OfflineQueueCompanion toCompanion(bool nullToAbsent) {
    return OfflineQueueCompanion(
      id: Value(id),
      action: Value(action),
      payload: Value(payload),
      createdAt: Value(createdAt),
      isProcessed: Value(isProcessed),
    );
  }

  factory OfflineQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineQueueData(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isProcessed: serializer.fromJson<bool>(json['isProcessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isProcessed': serializer.toJson<bool>(isProcessed),
    };
  }

  OfflineQueueData copyWith({
    int? id,
    String? action,
    String? payload,
    DateTime? createdAt,
    bool? isProcessed,
  }) => OfflineQueueData(
    id: id ?? this.id,
    action: action ?? this.action,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    isProcessed: isProcessed ?? this.isProcessed,
  );
  OfflineQueueData copyWithCompanion(OfflineQueueCompanion data) {
    return OfflineQueueData(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isProcessed: data.isProcessed.present
          ? data.isProcessed.value
          : this.isProcessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueData(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('isProcessed: $isProcessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, action, payload, createdAt, isProcessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineQueueData &&
          other.id == this.id &&
          other.action == this.action &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.isProcessed == this.isProcessed);
}

class OfflineQueueCompanion extends UpdateCompanion<OfflineQueueData> {
  final Value<int> id;
  final Value<String> action;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<bool> isProcessed;
  const OfflineQueueCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isProcessed = const Value.absent(),
  });
  OfflineQueueCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    required String payload,
    this.createdAt = const Value.absent(),
    this.isProcessed = const Value.absent(),
  }) : action = Value(action),
       payload = Value(payload);
  static Insertable<OfflineQueueData> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<bool>? isProcessed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (isProcessed != null) 'is_processed': isProcessed,
    });
  }

  OfflineQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<bool>? isProcessed,
  }) {
    return OfflineQueueCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      isProcessed: isProcessed ?? this.isProcessed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isProcessed.present) {
      map['is_processed'] = Variable<bool>(isProcessed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('isProcessed: $isProcessed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OfflineQueueTable offlineQueue = $OfflineQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [offlineQueue];
}

typedef $$OfflineQueueTableCreateCompanionBuilder =
    OfflineQueueCompanion Function({
      Value<int> id,
      required String action,
      required String payload,
      Value<DateTime> createdAt,
      Value<bool> isProcessed,
    });
typedef $$OfflineQueueTableUpdateCompanionBuilder =
    OfflineQueueCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<bool> isProcessed,
    });

class $$OfflineQueueTableFilterComposer
    extends Composer<_$AppDatabase, $OfflineQueueTable> {
  $$OfflineQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflineQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflineQueueTable> {
  $$OfflineQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflineQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflineQueueTable> {
  $$OfflineQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => column,
  );
}

class $$OfflineQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflineQueueTable,
          OfflineQueueData,
          $$OfflineQueueTableFilterComposer,
          $$OfflineQueueTableOrderingComposer,
          $$OfflineQueueTableAnnotationComposer,
          $$OfflineQueueTableCreateCompanionBuilder,
          $$OfflineQueueTableUpdateCompanionBuilder,
          (
            OfflineQueueData,
            BaseReferences<_$AppDatabase, $OfflineQueueTable, OfflineQueueData>,
          ),
          OfflineQueueData,
          PrefetchHooks Function()
        > {
  $$OfflineQueueTableTableManager(_$AppDatabase db, $OfflineQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isProcessed = const Value.absent(),
              }) => OfflineQueueCompanion(
                id: id,
                action: action,
                payload: payload,
                createdAt: createdAt,
                isProcessed: isProcessed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                required String payload,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isProcessed = const Value.absent(),
              }) => OfflineQueueCompanion.insert(
                id: id,
                action: action,
                payload: payload,
                createdAt: createdAt,
                isProcessed: isProcessed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflineQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflineQueueTable,
      OfflineQueueData,
      $$OfflineQueueTableFilterComposer,
      $$OfflineQueueTableOrderingComposer,
      $$OfflineQueueTableAnnotationComposer,
      $$OfflineQueueTableCreateCompanionBuilder,
      $$OfflineQueueTableUpdateCompanionBuilder,
      (
        OfflineQueueData,
        BaseReferences<_$AppDatabase, $OfflineQueueTable, OfflineQueueData>,
      ),
      OfflineQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OfflineQueueTableTableManager get offlineQueue =>
      $$OfflineQueueTableTableManager(_db, _db.offlineQueue);
}
