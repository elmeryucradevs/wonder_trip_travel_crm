// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _travelerNumberMeta = const VerificationMeta(
    'travelerNumber',
  );
  @override
  late final GeneratedColumn<String> travelerNumber = GeneratedColumn<String>(
    'traveler_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingNameMeta = const VerificationMeta(
    'billingName',
  );
  @override
  late final GeneratedColumn<String> billingName = GeneratedColumn<String>(
    'billing_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingDocumentMeta = const VerificationMeta(
    'billingDocument',
  );
  @override
  late final GeneratedColumn<String> billingDocument = GeneratedColumn<String>(
    'billing_document',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingAddressMeta = const VerificationMeta(
    'billingAddress',
  );
  @override
  late final GeneratedColumn<String> billingAddress = GeneratedColumn<String>(
    'billing_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    lastName,
    email,
    phone,
    documentType,
    documentNumber,
    birthDate,
    travelerNumber,
    billingName,
    billingDocument,
    billingAddress,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('traveler_number')) {
      context.handle(
        _travelerNumberMeta,
        travelerNumber.isAcceptableOrUnknown(
          data['traveler_number']!,
          _travelerNumberMeta,
        ),
      );
    }
    if (data.containsKey('billing_name')) {
      context.handle(
        _billingNameMeta,
        billingName.isAcceptableOrUnknown(
          data['billing_name']!,
          _billingNameMeta,
        ),
      );
    }
    if (data.containsKey('billing_document')) {
      context.handle(
        _billingDocumentMeta,
        billingDocument.isAcceptableOrUnknown(
          data['billing_document']!,
          _billingDocumentMeta,
        ),
      );
    }
    if (data.containsKey('billing_address')) {
      context.handle(
        _billingAddressMeta,
        billingAddress.isAcceptableOrUnknown(
          data['billing_address']!,
          _billingAddressMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      ),
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      travelerNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}traveler_number'],
      ),
      billingName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_name'],
      ),
      billingDocument: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_document'],
      ),
      billingAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String? documentType;
  final String? documentNumber;
  final DateTime? birthDate;
  final String? travelerNumber;
  final String? billingName;
  final String? billingDocument;
  final String? billingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Client({
    required this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.documentType,
    this.documentNumber,
    this.birthDate,
    this.travelerNumber,
    this.billingName,
    this.billingDocument,
    this.billingAddress,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || documentType != null) {
      map['document_type'] = Variable<String>(documentType);
    }
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || travelerNumber != null) {
      map['traveler_number'] = Variable<String>(travelerNumber);
    }
    if (!nullToAbsent || billingName != null) {
      map['billing_name'] = Variable<String>(billingName);
    }
    if (!nullToAbsent || billingDocument != null) {
      map['billing_document'] = Variable<String>(billingDocument);
    }
    if (!nullToAbsent || billingAddress != null) {
      map['billing_address'] = Variable<String>(billingAddress);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      lastName: Value(lastName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      documentType: documentType == null && nullToAbsent
          ? const Value.absent()
          : Value(documentType),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      travelerNumber: travelerNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(travelerNumber),
      billingName: billingName == null && nullToAbsent
          ? const Value.absent()
          : Value(billingName),
      billingDocument: billingDocument == null && nullToAbsent
          ? const Value.absent()
          : Value(billingDocument),
      billingAddress: billingAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(billingAddress),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      documentType: serializer.fromJson<String?>(json['documentType']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      travelerNumber: serializer.fromJson<String?>(json['travelerNumber']),
      billingName: serializer.fromJson<String?>(json['billingName']),
      billingDocument: serializer.fromJson<String?>(json['billingDocument']),
      billingAddress: serializer.fromJson<String?>(json['billingAddress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'documentType': serializer.toJson<String?>(documentType),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'travelerNumber': serializer.toJson<String?>(travelerNumber),
      'billingName': serializer.toJson<String?>(billingName),
      'billingDocument': serializer.toJson<String?>(billingDocument),
      'billingAddress': serializer.toJson<String?>(billingAddress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Client copyWith({
    int? id,
    String? name,
    String? lastName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> documentType = const Value.absent(),
    Value<String?> documentNumber = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> travelerNumber = const Value.absent(),
    Value<String?> billingName = const Value.absent(),
    Value<String?> billingDocument = const Value.absent(),
    Value<String?> billingAddress = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    documentType: documentType.present ? documentType.value : this.documentType,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    travelerNumber: travelerNumber.present
        ? travelerNumber.value
        : this.travelerNumber,
    billingName: billingName.present ? billingName.value : this.billingName,
    billingDocument: billingDocument.present
        ? billingDocument.value
        : this.billingDocument,
    billingAddress: billingAddress.present
        ? billingAddress.value
        : this.billingAddress,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      travelerNumber: data.travelerNumber.present
          ? data.travelerNumber.value
          : this.travelerNumber,
      billingName: data.billingName.present
          ? data.billingName.value
          : this.billingName,
      billingDocument: data.billingDocument.present
          ? data.billingDocument.value
          : this.billingDocument,
      billingAddress: data.billingAddress.present
          ? data.billingAddress.value
          : this.billingAddress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('birthDate: $birthDate, ')
          ..write('travelerNumber: $travelerNumber, ')
          ..write('billingName: $billingName, ')
          ..write('billingDocument: $billingDocument, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    lastName,
    email,
    phone,
    documentType,
    documentNumber,
    birthDate,
    travelerNumber,
    billingName,
    billingDocument,
    billingAddress,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.documentType == this.documentType &&
          other.documentNumber == this.documentNumber &&
          other.birthDate == this.birthDate &&
          other.travelerNumber == this.travelerNumber &&
          other.billingName == this.billingName &&
          other.billingDocument == this.billingDocument &&
          other.billingAddress == this.billingAddress &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> documentType;
  final Value<String?> documentNumber;
  final Value<DateTime?> birthDate;
  final Value<String?> travelerNumber;
  final Value<String?> billingName;
  final Value<String?> billingDocument;
  final Value<String?> billingAddress;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.travelerNumber = const Value.absent(),
    this.billingName = const Value.absent(),
    this.billingDocument = const Value.absent(),
    this.billingAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String lastName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.travelerNumber = const Value.absent(),
    this.billingName = const Value.absent(),
    this.billingDocument = const Value.absent(),
    this.billingAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       lastName = Value(lastName);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? documentType,
    Expression<String>? documentNumber,
    Expression<DateTime>? birthDate,
    Expression<String>? travelerNumber,
    Expression<String>? billingName,
    Expression<String>? billingDocument,
    Expression<String>? billingAddress,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (documentType != null) 'document_type': documentType,
      if (documentNumber != null) 'document_number': documentNumber,
      if (birthDate != null) 'birth_date': birthDate,
      if (travelerNumber != null) 'traveler_number': travelerNumber,
      if (billingName != null) 'billing_name': billingName,
      if (billingDocument != null) 'billing_document': billingDocument,
      if (billingAddress != null) 'billing_address': billingAddress,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? lastName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? documentType,
    Value<String?>? documentNumber,
    Value<DateTime?>? birthDate,
    Value<String?>? travelerNumber,
    Value<String?>? billingName,
    Value<String?>? billingDocument,
    Value<String?>? billingAddress,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      birthDate: birthDate ?? this.birthDate,
      travelerNumber: travelerNumber ?? this.travelerNumber,
      billingName: billingName ?? this.billingName,
      billingDocument: billingDocument ?? this.billingDocument,
      billingAddress: billingAddress ?? this.billingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (travelerNumber.present) {
      map['traveler_number'] = Variable<String>(travelerNumber.value);
    }
    if (billingName.present) {
      map['billing_name'] = Variable<String>(billingName.value);
    }
    if (billingDocument.present) {
      map['billing_document'] = Variable<String>(billingDocument.value);
    }
    if (billingAddress.present) {
      map['billing_address'] = Variable<String>(billingAddress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('birthDate: $birthDate, ')
          ..write('travelerNumber: $travelerNumber, ')
          ..write('billingName: $billingName, ')
          ..write('billingDocument: $billingDocument, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TicketsTable extends Tickets with TableInfo<$TicketsTable, Ticket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _pnrMeta = const VerificationMeta('pnr');
  @override
  late final GeneratedColumn<String> pnr = GeneratedColumn<String>(
    'pnr',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 6,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emissionDateMeta = const VerificationMeta(
    'emissionDate',
  );
  @override
  late final GeneratedColumn<DateTime> emissionDate = GeneratedColumn<DateTime>(
    'emission_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transportTypeMeta = const VerificationMeta(
    'transportType',
  );
  @override
  late final GeneratedColumn<String> transportType = GeneratedColumn<String>(
    'transport_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AEREO'),
  );
  static const VerificationMeta _ticketNumberMeta = const VerificationMeta(
    'ticketNumber',
  );
  @override
  late final GeneratedColumn<String> ticketNumber = GeneratedColumn<String>(
    'ticket_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flightTypeMeta = const VerificationMeta(
    'flightType',
  );
  @override
  late final GeneratedColumn<String> flightType = GeneratedColumn<String>(
    'flight_type',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 2,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passengerCategoryMeta = const VerificationMeta(
    'passengerCategory',
  );
  @override
  late final GeneratedColumn<String> passengerCategory =
      GeneratedColumn<String>(
        'passenger_category',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 3,
          maxTextLength: 3,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unaccompaniedMinorMeta =
      const VerificationMeta('unaccompaniedMinor');
  @override
  late final GeneratedColumn<bool> unaccompaniedMinor = GeneratedColumn<bool>(
    'unaccompanied_minor',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unaccompanied_minor" IN (0, 1))',
    ),
  );
  static const VerificationMeta _issuingAgentMeta = const VerificationMeta(
    'issuingAgent',
  );
  @override
  late final GeneratedColumn<String> issuingAgent = GeneratedColumn<String>(
    'issuing_agent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commissionMeta = const VerificationMeta(
    'commission',
  );
  @override
  late final GeneratedColumn<double> commission = GeneratedColumn<double>(
    'commission',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTicketIdMeta = const VerificationMeta(
    'originalTicketId',
  );
  @override
  late final GeneratedColumn<int> originalTicketId = GeneratedColumn<int>(
    'original_ticket_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tickets (id)',
    ),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    pnr,
    emissionDate,
    transportType,
    ticketNumber,
    flightType,
    passengerCategory,
    unaccompaniedMinor,
    issuingAgent,
    status,
    currency,
    totalPrice,
    commission,
    originalTicketId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tickets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ticket> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('pnr')) {
      context.handle(
        _pnrMeta,
        pnr.isAcceptableOrUnknown(data['pnr']!, _pnrMeta),
      );
    } else if (isInserting) {
      context.missing(_pnrMeta);
    }
    if (data.containsKey('emission_date')) {
      context.handle(
        _emissionDateMeta,
        emissionDate.isAcceptableOrUnknown(
          data['emission_date']!,
          _emissionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emissionDateMeta);
    }
    if (data.containsKey('transport_type')) {
      context.handle(
        _transportTypeMeta,
        transportType.isAcceptableOrUnknown(
          data['transport_type']!,
          _transportTypeMeta,
        ),
      );
    }
    if (data.containsKey('ticket_number')) {
      context.handle(
        _ticketNumberMeta,
        ticketNumber.isAcceptableOrUnknown(
          data['ticket_number']!,
          _ticketNumberMeta,
        ),
      );
    }
    if (data.containsKey('flight_type')) {
      context.handle(
        _flightTypeMeta,
        flightType.isAcceptableOrUnknown(data['flight_type']!, _flightTypeMeta),
      );
    }
    if (data.containsKey('passenger_category')) {
      context.handle(
        _passengerCategoryMeta,
        passengerCategory.isAcceptableOrUnknown(
          data['passenger_category']!,
          _passengerCategoryMeta,
        ),
      );
    }
    if (data.containsKey('unaccompanied_minor')) {
      context.handle(
        _unaccompaniedMinorMeta,
        unaccompaniedMinor.isAcceptableOrUnknown(
          data['unaccompanied_minor']!,
          _unaccompaniedMinorMeta,
        ),
      );
    }
    if (data.containsKey('issuing_agent')) {
      context.handle(
        _issuingAgentMeta,
        issuingAgent.isAcceptableOrUnknown(
          data['issuing_agent']!,
          _issuingAgentMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('commission')) {
      context.handle(
        _commissionMeta,
        commission.isAcceptableOrUnknown(data['commission']!, _commissionMeta),
      );
    }
    if (data.containsKey('original_ticket_id')) {
      context.handle(
        _originalTicketIdMeta,
        originalTicketId.isAcceptableOrUnknown(
          data['original_ticket_id']!,
          _originalTicketIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ticket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ticket(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      pnr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pnr'],
      )!,
      emissionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}emission_date'],
      )!,
      transportType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transport_type'],
      )!,
      ticketNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticket_number'],
      ),
      flightType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flight_type'],
      ),
      passengerCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passenger_category'],
      ),
      unaccompaniedMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unaccompanied_minor'],
      ),
      issuingAgent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuing_agent'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      commission: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission'],
      ),
      originalTicketId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_ticket_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TicketsTable createAlias(String alias) {
    return $TicketsTable(attachedDatabase, alias);
  }
}

class Ticket extends DataClass implements Insertable<Ticket> {
  final int id;
  final int clientId;
  final String pnr;
  final DateTime emissionDate;

  /// Tipo de transporte: 'AEREO' o 'TERRESTRE'.
  final String transportType;

  /// Número de boleto completo.
  final String? ticketNumber;

  /// Tipo de Vuelo: OW (One-Way) o RT (Round-Trip).
  final String? flightType;

  /// Categoría del Pasajero: ADT (Adulto), CHD (Niño), INF (Infante), SNN (Adulto Mayor).
  final String? passengerCategory;

  /// NUEVO: Indica si el menor viaja solo.
  final bool? unaccompaniedMinor;

  /// Proveedor o agente que emitió el boleto.
  final String? issuingAgent;

  /// Estado del boleto: CONFIRMADO, CANCELADO, REEMBOLSADO.
  final String? status;
  final String currency;
  final double totalPrice;

  /// La comisión que recibe la agencia por la venta de este boleto.
  final double? commission;

  /// Si este boleto fue emitido por un cambio, aquí se guarda el ID del boleto original.
  final int? originalTicketId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Ticket({
    required this.id,
    required this.clientId,
    required this.pnr,
    required this.emissionDate,
    required this.transportType,
    this.ticketNumber,
    this.flightType,
    this.passengerCategory,
    this.unaccompaniedMinor,
    this.issuingAgent,
    this.status,
    required this.currency,
    required this.totalPrice,
    this.commission,
    this.originalTicketId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['pnr'] = Variable<String>(pnr);
    map['emission_date'] = Variable<DateTime>(emissionDate);
    map['transport_type'] = Variable<String>(transportType);
    if (!nullToAbsent || ticketNumber != null) {
      map['ticket_number'] = Variable<String>(ticketNumber);
    }
    if (!nullToAbsent || flightType != null) {
      map['flight_type'] = Variable<String>(flightType);
    }
    if (!nullToAbsent || passengerCategory != null) {
      map['passenger_category'] = Variable<String>(passengerCategory);
    }
    if (!nullToAbsent || unaccompaniedMinor != null) {
      map['unaccompanied_minor'] = Variable<bool>(unaccompaniedMinor);
    }
    if (!nullToAbsent || issuingAgent != null) {
      map['issuing_agent'] = Variable<String>(issuingAgent);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    map['currency'] = Variable<String>(currency);
    map['total_price'] = Variable<double>(totalPrice);
    if (!nullToAbsent || commission != null) {
      map['commission'] = Variable<double>(commission);
    }
    if (!nullToAbsent || originalTicketId != null) {
      map['original_ticket_id'] = Variable<int>(originalTicketId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TicketsCompanion toCompanion(bool nullToAbsent) {
    return TicketsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      pnr: Value(pnr),
      emissionDate: Value(emissionDate),
      transportType: Value(transportType),
      ticketNumber: ticketNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketNumber),
      flightType: flightType == null && nullToAbsent
          ? const Value.absent()
          : Value(flightType),
      passengerCategory: passengerCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(passengerCategory),
      unaccompaniedMinor: unaccompaniedMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(unaccompaniedMinor),
      issuingAgent: issuingAgent == null && nullToAbsent
          ? const Value.absent()
          : Value(issuingAgent),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      currency: Value(currency),
      totalPrice: Value(totalPrice),
      commission: commission == null && nullToAbsent
          ? const Value.absent()
          : Value(commission),
      originalTicketId: originalTicketId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTicketId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Ticket.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ticket(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      pnr: serializer.fromJson<String>(json['pnr']),
      emissionDate: serializer.fromJson<DateTime>(json['emissionDate']),
      transportType: serializer.fromJson<String>(json['transportType']),
      ticketNumber: serializer.fromJson<String?>(json['ticketNumber']),
      flightType: serializer.fromJson<String?>(json['flightType']),
      passengerCategory: serializer.fromJson<String?>(
        json['passengerCategory'],
      ),
      unaccompaniedMinor: serializer.fromJson<bool?>(
        json['unaccompaniedMinor'],
      ),
      issuingAgent: serializer.fromJson<String?>(json['issuingAgent']),
      status: serializer.fromJson<String?>(json['status']),
      currency: serializer.fromJson<String>(json['currency']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      commission: serializer.fromJson<double?>(json['commission']),
      originalTicketId: serializer.fromJson<int?>(json['originalTicketId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'pnr': serializer.toJson<String>(pnr),
      'emissionDate': serializer.toJson<DateTime>(emissionDate),
      'transportType': serializer.toJson<String>(transportType),
      'ticketNumber': serializer.toJson<String?>(ticketNumber),
      'flightType': serializer.toJson<String?>(flightType),
      'passengerCategory': serializer.toJson<String?>(passengerCategory),
      'unaccompaniedMinor': serializer.toJson<bool?>(unaccompaniedMinor),
      'issuingAgent': serializer.toJson<String?>(issuingAgent),
      'status': serializer.toJson<String?>(status),
      'currency': serializer.toJson<String>(currency),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'commission': serializer.toJson<double?>(commission),
      'originalTicketId': serializer.toJson<int?>(originalTicketId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Ticket copyWith({
    int? id,
    int? clientId,
    String? pnr,
    DateTime? emissionDate,
    String? transportType,
    Value<String?> ticketNumber = const Value.absent(),
    Value<String?> flightType = const Value.absent(),
    Value<String?> passengerCategory = const Value.absent(),
    Value<bool?> unaccompaniedMinor = const Value.absent(),
    Value<String?> issuingAgent = const Value.absent(),
    Value<String?> status = const Value.absent(),
    String? currency,
    double? totalPrice,
    Value<double?> commission = const Value.absent(),
    Value<int?> originalTicketId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Ticket(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    pnr: pnr ?? this.pnr,
    emissionDate: emissionDate ?? this.emissionDate,
    transportType: transportType ?? this.transportType,
    ticketNumber: ticketNumber.present ? ticketNumber.value : this.ticketNumber,
    flightType: flightType.present ? flightType.value : this.flightType,
    passengerCategory: passengerCategory.present
        ? passengerCategory.value
        : this.passengerCategory,
    unaccompaniedMinor: unaccompaniedMinor.present
        ? unaccompaniedMinor.value
        : this.unaccompaniedMinor,
    issuingAgent: issuingAgent.present ? issuingAgent.value : this.issuingAgent,
    status: status.present ? status.value : this.status,
    currency: currency ?? this.currency,
    totalPrice: totalPrice ?? this.totalPrice,
    commission: commission.present ? commission.value : this.commission,
    originalTicketId: originalTicketId.present
        ? originalTicketId.value
        : this.originalTicketId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Ticket copyWithCompanion(TicketsCompanion data) {
    return Ticket(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      pnr: data.pnr.present ? data.pnr.value : this.pnr,
      emissionDate: data.emissionDate.present
          ? data.emissionDate.value
          : this.emissionDate,
      transportType: data.transportType.present
          ? data.transportType.value
          : this.transportType,
      ticketNumber: data.ticketNumber.present
          ? data.ticketNumber.value
          : this.ticketNumber,
      flightType: data.flightType.present
          ? data.flightType.value
          : this.flightType,
      passengerCategory: data.passengerCategory.present
          ? data.passengerCategory.value
          : this.passengerCategory,
      unaccompaniedMinor: data.unaccompaniedMinor.present
          ? data.unaccompaniedMinor.value
          : this.unaccompaniedMinor,
      issuingAgent: data.issuingAgent.present
          ? data.issuingAgent.value
          : this.issuingAgent,
      status: data.status.present ? data.status.value : this.status,
      currency: data.currency.present ? data.currency.value : this.currency,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      commission: data.commission.present
          ? data.commission.value
          : this.commission,
      originalTicketId: data.originalTicketId.present
          ? data.originalTicketId.value
          : this.originalTicketId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ticket(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('pnr: $pnr, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('transportType: $transportType, ')
          ..write('ticketNumber: $ticketNumber, ')
          ..write('flightType: $flightType, ')
          ..write('passengerCategory: $passengerCategory, ')
          ..write('unaccompaniedMinor: $unaccompaniedMinor, ')
          ..write('issuingAgent: $issuingAgent, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('commission: $commission, ')
          ..write('originalTicketId: $originalTicketId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    pnr,
    emissionDate,
    transportType,
    ticketNumber,
    flightType,
    passengerCategory,
    unaccompaniedMinor,
    issuingAgent,
    status,
    currency,
    totalPrice,
    commission,
    originalTicketId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ticket &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.pnr == this.pnr &&
          other.emissionDate == this.emissionDate &&
          other.transportType == this.transportType &&
          other.ticketNumber == this.ticketNumber &&
          other.flightType == this.flightType &&
          other.passengerCategory == this.passengerCategory &&
          other.unaccompaniedMinor == this.unaccompaniedMinor &&
          other.issuingAgent == this.issuingAgent &&
          other.status == this.status &&
          other.currency == this.currency &&
          other.totalPrice == this.totalPrice &&
          other.commission == this.commission &&
          other.originalTicketId == this.originalTicketId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TicketsCompanion extends UpdateCompanion<Ticket> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> pnr;
  final Value<DateTime> emissionDate;
  final Value<String> transportType;
  final Value<String?> ticketNumber;
  final Value<String?> flightType;
  final Value<String?> passengerCategory;
  final Value<bool?> unaccompaniedMinor;
  final Value<String?> issuingAgent;
  final Value<String?> status;
  final Value<String> currency;
  final Value<double> totalPrice;
  final Value<double?> commission;
  final Value<int?> originalTicketId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TicketsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.pnr = const Value.absent(),
    this.emissionDate = const Value.absent(),
    this.transportType = const Value.absent(),
    this.ticketNumber = const Value.absent(),
    this.flightType = const Value.absent(),
    this.passengerCategory = const Value.absent(),
    this.unaccompaniedMinor = const Value.absent(),
    this.issuingAgent = const Value.absent(),
    this.status = const Value.absent(),
    this.currency = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.commission = const Value.absent(),
    this.originalTicketId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TicketsCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String pnr,
    required DateTime emissionDate,
    this.transportType = const Value.absent(),
    this.ticketNumber = const Value.absent(),
    this.flightType = const Value.absent(),
    this.passengerCategory = const Value.absent(),
    this.unaccompaniedMinor = const Value.absent(),
    this.issuingAgent = const Value.absent(),
    this.status = const Value.absent(),
    this.currency = const Value.absent(),
    required double totalPrice,
    this.commission = const Value.absent(),
    this.originalTicketId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       pnr = Value(pnr),
       emissionDate = Value(emissionDate),
       totalPrice = Value(totalPrice);
  static Insertable<Ticket> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? pnr,
    Expression<DateTime>? emissionDate,
    Expression<String>? transportType,
    Expression<String>? ticketNumber,
    Expression<String>? flightType,
    Expression<String>? passengerCategory,
    Expression<bool>? unaccompaniedMinor,
    Expression<String>? issuingAgent,
    Expression<String>? status,
    Expression<String>? currency,
    Expression<double>? totalPrice,
    Expression<double>? commission,
    Expression<int>? originalTicketId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (pnr != null) 'pnr': pnr,
      if (emissionDate != null) 'emission_date': emissionDate,
      if (transportType != null) 'transport_type': transportType,
      if (ticketNumber != null) 'ticket_number': ticketNumber,
      if (flightType != null) 'flight_type': flightType,
      if (passengerCategory != null) 'passenger_category': passengerCategory,
      if (unaccompaniedMinor != null) 'unaccompanied_minor': unaccompaniedMinor,
      if (issuingAgent != null) 'issuing_agent': issuingAgent,
      if (status != null) 'status': status,
      if (currency != null) 'currency': currency,
      if (totalPrice != null) 'total_price': totalPrice,
      if (commission != null) 'commission': commission,
      if (originalTicketId != null) 'original_ticket_id': originalTicketId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TicketsCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<String>? pnr,
    Value<DateTime>? emissionDate,
    Value<String>? transportType,
    Value<String?>? ticketNumber,
    Value<String?>? flightType,
    Value<String?>? passengerCategory,
    Value<bool?>? unaccompaniedMinor,
    Value<String?>? issuingAgent,
    Value<String?>? status,
    Value<String>? currency,
    Value<double>? totalPrice,
    Value<double?>? commission,
    Value<int?>? originalTicketId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TicketsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      pnr: pnr ?? this.pnr,
      emissionDate: emissionDate ?? this.emissionDate,
      transportType: transportType ?? this.transportType,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      flightType: flightType ?? this.flightType,
      passengerCategory: passengerCategory ?? this.passengerCategory,
      unaccompaniedMinor: unaccompaniedMinor ?? this.unaccompaniedMinor,
      issuingAgent: issuingAgent ?? this.issuingAgent,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      totalPrice: totalPrice ?? this.totalPrice,
      commission: commission ?? this.commission,
      originalTicketId: originalTicketId ?? this.originalTicketId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (pnr.present) {
      map['pnr'] = Variable<String>(pnr.value);
    }
    if (emissionDate.present) {
      map['emission_date'] = Variable<DateTime>(emissionDate.value);
    }
    if (transportType.present) {
      map['transport_type'] = Variable<String>(transportType.value);
    }
    if (ticketNumber.present) {
      map['ticket_number'] = Variable<String>(ticketNumber.value);
    }
    if (flightType.present) {
      map['flight_type'] = Variable<String>(flightType.value);
    }
    if (passengerCategory.present) {
      map['passenger_category'] = Variable<String>(passengerCategory.value);
    }
    if (unaccompaniedMinor.present) {
      map['unaccompanied_minor'] = Variable<bool>(unaccompaniedMinor.value);
    }
    if (issuingAgent.present) {
      map['issuing_agent'] = Variable<String>(issuingAgent.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (commission.present) {
      map['commission'] = Variable<double>(commission.value);
    }
    if (originalTicketId.present) {
      map['original_ticket_id'] = Variable<int>(originalTicketId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('pnr: $pnr, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('transportType: $transportType, ')
          ..write('ticketNumber: $ticketNumber, ')
          ..write('flightType: $flightType, ')
          ..write('passengerCategory: $passengerCategory, ')
          ..write('unaccompaniedMinor: $unaccompaniedMinor, ')
          ..write('issuingAgent: $issuingAgent, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('commission: $commission, ')
          ..write('originalTicketId: $originalTicketId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlightSegmentsTable extends FlightSegments
    with TableInfo<$FlightSegmentsTable, FlightSegment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlightSegmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ticketIdMeta = const VerificationMeta(
    'ticketId',
  );
  @override
  late final GeneratedColumn<int> ticketId = GeneratedColumn<int>(
    'ticket_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tickets (id)',
    ),
  );
  static const VerificationMeta _airlineCodeMeta = const VerificationMeta(
    'airlineCode',
  );
  @override
  late final GeneratedColumn<String> airlineCode = GeneratedColumn<String>(
    'airline_code',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flightNumberMeta = const VerificationMeta(
    'flightNumber',
  );
  @override
  late final GeneratedColumn<String> flightNumber = GeneratedColumn<String>(
    'flight_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationMeta = const VerificationMeta(
    'destination',
  );
  @override
  late final GeneratedColumn<String> destination = GeneratedColumn<String>(
    'destination',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departureDateMeta = const VerificationMeta(
    'departureDate',
  );
  @override
  late final GeneratedColumn<DateTime> departureDate =
      GeneratedColumn<DateTime>(
        'departure_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _arrivalDateMeta = const VerificationMeta(
    'arrivalDate',
  );
  @override
  late final GeneratedColumn<DateTime> arrivalDate = GeneratedColumn<DateTime>(
    'arrival_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flightClassMeta = const VerificationMeta(
    'flightClass',
  );
  @override
  late final GeneratedColumn<String> flightClass = GeneratedColumn<String>(
    'flight_class',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stopoverMeta = const VerificationMeta(
    'stopover',
  );
  @override
  late final GeneratedColumn<String> stopover = GeneratedColumn<String>(
    'stopover',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ticketId,
    airlineCode,
    flightNumber,
    origin,
    destination,
    departureDate,
    arrivalDate,
    flightClass,
    stopover,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flight_segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlightSegment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ticket_id')) {
      context.handle(
        _ticketIdMeta,
        ticketId.isAcceptableOrUnknown(data['ticket_id']!, _ticketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ticketIdMeta);
    }
    if (data.containsKey('airline_code')) {
      context.handle(
        _airlineCodeMeta,
        airlineCode.isAcceptableOrUnknown(
          data['airline_code']!,
          _airlineCodeMeta,
        ),
      );
    }
    if (data.containsKey('flight_number')) {
      context.handle(
        _flightNumberMeta,
        flightNumber.isAcceptableOrUnknown(
          data['flight_number']!,
          _flightNumberMeta,
        ),
      );
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
        _destinationMeta,
        destination.isAcceptableOrUnknown(
          data['destination']!,
          _destinationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('departure_date')) {
      context.handle(
        _departureDateMeta,
        departureDate.isAcceptableOrUnknown(
          data['departure_date']!,
          _departureDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureDateMeta);
    }
    if (data.containsKey('arrival_date')) {
      context.handle(
        _arrivalDateMeta,
        arrivalDate.isAcceptableOrUnknown(
          data['arrival_date']!,
          _arrivalDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrivalDateMeta);
    }
    if (data.containsKey('flight_class')) {
      context.handle(
        _flightClassMeta,
        flightClass.isAcceptableOrUnknown(
          data['flight_class']!,
          _flightClassMeta,
        ),
      );
    }
    if (data.containsKey('stopover')) {
      context.handle(
        _stopoverMeta,
        stopover.isAcceptableOrUnknown(data['stopover']!, _stopoverMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlightSegment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlightSegment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ticketId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ticket_id'],
      )!,
      airlineCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}airline_code'],
      ),
      flightNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flight_number'],
      ),
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
      destination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination'],
      )!,
      departureDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}departure_date'],
      )!,
      arrivalDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}arrival_date'],
      )!,
      flightClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flight_class'],
      ),
      stopover: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stopover'],
      ),
    );
  }

  @override
  $FlightSegmentsTable createAlias(String alias) {
    return $FlightSegmentsTable(attachedDatabase, alias);
  }
}

class FlightSegment extends DataClass implements Insertable<FlightSegment> {
  final int id;
  final int ticketId;
  final String? airlineCode;
  final String? flightNumber;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String? flightClass;
  final String? stopover;
  const FlightSegment({
    required this.id,
    required this.ticketId,
    this.airlineCode,
    this.flightNumber,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.arrivalDate,
    this.flightClass,
    this.stopover,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ticket_id'] = Variable<int>(ticketId);
    if (!nullToAbsent || airlineCode != null) {
      map['airline_code'] = Variable<String>(airlineCode);
    }
    if (!nullToAbsent || flightNumber != null) {
      map['flight_number'] = Variable<String>(flightNumber);
    }
    map['origin'] = Variable<String>(origin);
    map['destination'] = Variable<String>(destination);
    map['departure_date'] = Variable<DateTime>(departureDate);
    map['arrival_date'] = Variable<DateTime>(arrivalDate);
    if (!nullToAbsent || flightClass != null) {
      map['flight_class'] = Variable<String>(flightClass);
    }
    if (!nullToAbsent || stopover != null) {
      map['stopover'] = Variable<String>(stopover);
    }
    return map;
  }

  FlightSegmentsCompanion toCompanion(bool nullToAbsent) {
    return FlightSegmentsCompanion(
      id: Value(id),
      ticketId: Value(ticketId),
      airlineCode: airlineCode == null && nullToAbsent
          ? const Value.absent()
          : Value(airlineCode),
      flightNumber: flightNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(flightNumber),
      origin: Value(origin),
      destination: Value(destination),
      departureDate: Value(departureDate),
      arrivalDate: Value(arrivalDate),
      flightClass: flightClass == null && nullToAbsent
          ? const Value.absent()
          : Value(flightClass),
      stopover: stopover == null && nullToAbsent
          ? const Value.absent()
          : Value(stopover),
    );
  }

  factory FlightSegment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlightSegment(
      id: serializer.fromJson<int>(json['id']),
      ticketId: serializer.fromJson<int>(json['ticketId']),
      airlineCode: serializer.fromJson<String?>(json['airlineCode']),
      flightNumber: serializer.fromJson<String?>(json['flightNumber']),
      origin: serializer.fromJson<String>(json['origin']),
      destination: serializer.fromJson<String>(json['destination']),
      departureDate: serializer.fromJson<DateTime>(json['departureDate']),
      arrivalDate: serializer.fromJson<DateTime>(json['arrivalDate']),
      flightClass: serializer.fromJson<String?>(json['flightClass']),
      stopover: serializer.fromJson<String?>(json['stopover']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticketId': serializer.toJson<int>(ticketId),
      'airlineCode': serializer.toJson<String?>(airlineCode),
      'flightNumber': serializer.toJson<String?>(flightNumber),
      'origin': serializer.toJson<String>(origin),
      'destination': serializer.toJson<String>(destination),
      'departureDate': serializer.toJson<DateTime>(departureDate),
      'arrivalDate': serializer.toJson<DateTime>(arrivalDate),
      'flightClass': serializer.toJson<String?>(flightClass),
      'stopover': serializer.toJson<String?>(stopover),
    };
  }

  FlightSegment copyWith({
    int? id,
    int? ticketId,
    Value<String?> airlineCode = const Value.absent(),
    Value<String?> flightNumber = const Value.absent(),
    String? origin,
    String? destination,
    DateTime? departureDate,
    DateTime? arrivalDate,
    Value<String?> flightClass = const Value.absent(),
    Value<String?> stopover = const Value.absent(),
  }) => FlightSegment(
    id: id ?? this.id,
    ticketId: ticketId ?? this.ticketId,
    airlineCode: airlineCode.present ? airlineCode.value : this.airlineCode,
    flightNumber: flightNumber.present ? flightNumber.value : this.flightNumber,
    origin: origin ?? this.origin,
    destination: destination ?? this.destination,
    departureDate: departureDate ?? this.departureDate,
    arrivalDate: arrivalDate ?? this.arrivalDate,
    flightClass: flightClass.present ? flightClass.value : this.flightClass,
    stopover: stopover.present ? stopover.value : this.stopover,
  );
  FlightSegment copyWithCompanion(FlightSegmentsCompanion data) {
    return FlightSegment(
      id: data.id.present ? data.id.value : this.id,
      ticketId: data.ticketId.present ? data.ticketId.value : this.ticketId,
      airlineCode: data.airlineCode.present
          ? data.airlineCode.value
          : this.airlineCode,
      flightNumber: data.flightNumber.present
          ? data.flightNumber.value
          : this.flightNumber,
      origin: data.origin.present ? data.origin.value : this.origin,
      destination: data.destination.present
          ? data.destination.value
          : this.destination,
      departureDate: data.departureDate.present
          ? data.departureDate.value
          : this.departureDate,
      arrivalDate: data.arrivalDate.present
          ? data.arrivalDate.value
          : this.arrivalDate,
      flightClass: data.flightClass.present
          ? data.flightClass.value
          : this.flightClass,
      stopover: data.stopover.present ? data.stopover.value : this.stopover,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlightSegment(')
          ..write('id: $id, ')
          ..write('ticketId: $ticketId, ')
          ..write('airlineCode: $airlineCode, ')
          ..write('flightNumber: $flightNumber, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('departureDate: $departureDate, ')
          ..write('arrivalDate: $arrivalDate, ')
          ..write('flightClass: $flightClass, ')
          ..write('stopover: $stopover')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ticketId,
    airlineCode,
    flightNumber,
    origin,
    destination,
    departureDate,
    arrivalDate,
    flightClass,
    stopover,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlightSegment &&
          other.id == this.id &&
          other.ticketId == this.ticketId &&
          other.airlineCode == this.airlineCode &&
          other.flightNumber == this.flightNumber &&
          other.origin == this.origin &&
          other.destination == this.destination &&
          other.departureDate == this.departureDate &&
          other.arrivalDate == this.arrivalDate &&
          other.flightClass == this.flightClass &&
          other.stopover == this.stopover);
}

class FlightSegmentsCompanion extends UpdateCompanion<FlightSegment> {
  final Value<int> id;
  final Value<int> ticketId;
  final Value<String?> airlineCode;
  final Value<String?> flightNumber;
  final Value<String> origin;
  final Value<String> destination;
  final Value<DateTime> departureDate;
  final Value<DateTime> arrivalDate;
  final Value<String?> flightClass;
  final Value<String?> stopover;
  const FlightSegmentsCompanion({
    this.id = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.airlineCode = const Value.absent(),
    this.flightNumber = const Value.absent(),
    this.origin = const Value.absent(),
    this.destination = const Value.absent(),
    this.departureDate = const Value.absent(),
    this.arrivalDate = const Value.absent(),
    this.flightClass = const Value.absent(),
    this.stopover = const Value.absent(),
  });
  FlightSegmentsCompanion.insert({
    this.id = const Value.absent(),
    required int ticketId,
    this.airlineCode = const Value.absent(),
    this.flightNumber = const Value.absent(),
    required String origin,
    required String destination,
    required DateTime departureDate,
    required DateTime arrivalDate,
    this.flightClass = const Value.absent(),
    this.stopover = const Value.absent(),
  }) : ticketId = Value(ticketId),
       origin = Value(origin),
       destination = Value(destination),
       departureDate = Value(departureDate),
       arrivalDate = Value(arrivalDate);
  static Insertable<FlightSegment> custom({
    Expression<int>? id,
    Expression<int>? ticketId,
    Expression<String>? airlineCode,
    Expression<String>? flightNumber,
    Expression<String>? origin,
    Expression<String>? destination,
    Expression<DateTime>? departureDate,
    Expression<DateTime>? arrivalDate,
    Expression<String>? flightClass,
    Expression<String>? stopover,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticketId != null) 'ticket_id': ticketId,
      if (airlineCode != null) 'airline_code': airlineCode,
      if (flightNumber != null) 'flight_number': flightNumber,
      if (origin != null) 'origin': origin,
      if (destination != null) 'destination': destination,
      if (departureDate != null) 'departure_date': departureDate,
      if (arrivalDate != null) 'arrival_date': arrivalDate,
      if (flightClass != null) 'flight_class': flightClass,
      if (stopover != null) 'stopover': stopover,
    });
  }

  FlightSegmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? ticketId,
    Value<String?>? airlineCode,
    Value<String?>? flightNumber,
    Value<String>? origin,
    Value<String>? destination,
    Value<DateTime>? departureDate,
    Value<DateTime>? arrivalDate,
    Value<String?>? flightClass,
    Value<String?>? stopover,
  }) {
    return FlightSegmentsCompanion(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      airlineCode: airlineCode ?? this.airlineCode,
      flightNumber: flightNumber ?? this.flightNumber,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departureDate: departureDate ?? this.departureDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      flightClass: flightClass ?? this.flightClass,
      stopover: stopover ?? this.stopover,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<int>(ticketId.value);
    }
    if (airlineCode.present) {
      map['airline_code'] = Variable<String>(airlineCode.value);
    }
    if (flightNumber.present) {
      map['flight_number'] = Variable<String>(flightNumber.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (departureDate.present) {
      map['departure_date'] = Variable<DateTime>(departureDate.value);
    }
    if (arrivalDate.present) {
      map['arrival_date'] = Variable<DateTime>(arrivalDate.value);
    }
    if (flightClass.present) {
      map['flight_class'] = Variable<String>(flightClass.value);
    }
    if (stopover.present) {
      map['stopover'] = Variable<String>(stopover.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlightSegmentsCompanion(')
          ..write('id: $id, ')
          ..write('ticketId: $ticketId, ')
          ..write('airlineCode: $airlineCode, ')
          ..write('flightNumber: $flightNumber, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('departureDate: $departureDate, ')
          ..write('arrivalDate: $arrivalDate, ')
          ..write('flightClass: $flightClass, ')
          ..write('stopover: $stopover')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $TicketsTable tickets = $TicketsTable(this);
  late final $FlightSegmentsTable flightSegments = $FlightSegmentsTable(this);
  late final ClientDao clientDao = ClientDao(this as AppDatabase);
  late final TicketDao ticketDao = TicketDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    tickets,
    flightSegments,
  ];
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String name,
      required String lastName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> documentType,
      Value<String?> documentNumber,
      Value<DateTime?> birthDate,
      Value<String?> travelerNumber,
      Value<String?> billingName,
      Value<String?> billingDocument,
      Value<String?> billingAddress,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> lastName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> documentType,
      Value<String?> documentNumber,
      Value<DateTime?> birthDate,
      Value<String?> travelerNumber,
      Value<String?> billingName,
      Value<String?> billingDocument,
      Value<String?> billingAddress,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TicketsTable, List<Ticket>> _ticketsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tickets,
    aliasName: $_aliasNameGenerator(db.clients.id, db.tickets.clientId),
  );

  $$TicketsTableProcessedTableManager get ticketsRefs {
    final manager = $$TicketsTableTableManager(
      $_db,
      $_db.tickets,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get travelerNumber => $composableBuilder(
    column: $table.travelerNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingName => $composableBuilder(
    column: $table.billingName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingDocument => $composableBuilder(
    column: $table.billingDocument,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ticketsRefs(
    Expression<bool> Function($$TicketsTableFilterComposer f) f,
  ) {
    final $$TicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableFilterComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get travelerNumber => $composableBuilder(
    column: $table.travelerNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingName => $composableBuilder(
    column: $table.billingName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingDocument => $composableBuilder(
    column: $table.billingDocument,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get travelerNumber => $composableBuilder(
    column: $table.travelerNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingName => $composableBuilder(
    column: $table.billingName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingDocument => $composableBuilder(
    column: $table.billingDocument,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingAddress => $composableBuilder(
    column: $table.billingAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> ticketsRefs<T extends Object>(
    Expression<T> Function($$TicketsTableAnnotationComposer a) f,
  ) {
    final $$TicketsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableAnnotationComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({bool ticketsRefs})
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> documentType = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> travelerNumber = const Value.absent(),
                Value<String?> billingName = const Value.absent(),
                Value<String?> billingDocument = const Value.absent(),
                Value<String?> billingAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                name: name,
                lastName: lastName,
                email: email,
                phone: phone,
                documentType: documentType,
                documentNumber: documentNumber,
                birthDate: birthDate,
                travelerNumber: travelerNumber,
                billingName: billingName,
                billingDocument: billingDocument,
                billingAddress: billingAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String lastName,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> documentType = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> travelerNumber = const Value.absent(),
                Value<String?> billingName = const Value.absent(),
                Value<String?> billingDocument = const Value.absent(),
                Value<String?> billingAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                name: name,
                lastName: lastName,
                email: email,
                phone: phone,
                documentType: documentType,
                documentNumber: documentNumber,
                birthDate: birthDate,
                travelerNumber: travelerNumber,
                billingName: billingName,
                billingDocument: billingDocument,
                billingAddress: billingAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ticketsRefs) db.tickets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ticketsRefs)
                    await $_getPrefetchedData<Client, $ClientsTable, Ticket>(
                      currentTable: table,
                      referencedTable: $$ClientsTableReferences
                          ._ticketsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientsTableReferences(db, table, p0).ticketsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({bool ticketsRefs})
    >;
typedef $$TicketsTableCreateCompanionBuilder =
    TicketsCompanion Function({
      Value<int> id,
      required int clientId,
      required String pnr,
      required DateTime emissionDate,
      Value<String> transportType,
      Value<String?> ticketNumber,
      Value<String?> flightType,
      Value<String?> passengerCategory,
      Value<bool?> unaccompaniedMinor,
      Value<String?> issuingAgent,
      Value<String?> status,
      Value<String> currency,
      required double totalPrice,
      Value<double?> commission,
      Value<int?> originalTicketId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TicketsTableUpdateCompanionBuilder =
    TicketsCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<String> pnr,
      Value<DateTime> emissionDate,
      Value<String> transportType,
      Value<String?> ticketNumber,
      Value<String?> flightType,
      Value<String?> passengerCategory,
      Value<bool?> unaccompaniedMinor,
      Value<String?> issuingAgent,
      Value<String?> status,
      Value<String> currency,
      Value<double> totalPrice,
      Value<double?> commission,
      Value<int?> originalTicketId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TicketsTableReferences
    extends BaseReferences<_$AppDatabase, $TicketsTable, Ticket> {
  $$TicketsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.tickets.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TicketsTable _originalTicketIdTable(_$AppDatabase db) =>
      db.tickets.createAlias(
        $_aliasNameGenerator(db.tickets.originalTicketId, db.tickets.id),
      );

  $$TicketsTableProcessedTableManager? get originalTicketId {
    final $_column = $_itemColumn<int>('original_ticket_id');
    if ($_column == null) return null;
    final manager = $$TicketsTableTableManager(
      $_db,
      $_db.tickets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_originalTicketIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlightSegmentsTable, List<FlightSegment>>
  _flightSegmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flightSegments,
    aliasName: $_aliasNameGenerator(db.tickets.id, db.flightSegments.ticketId),
  );

  $$FlightSegmentsTableProcessedTableManager get flightSegmentsRefs {
    final manager = $$FlightSegmentsTableTableManager(
      $_db,
      $_db.flightSegments,
    ).filter((f) => f.ticketId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_flightSegmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TicketsTableFilterComposer
    extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableFilterComposer({
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

  ColumnFilters<String> get pnr => $composableBuilder(
    column: $table.pnr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transportType => $composableBuilder(
    column: $table.transportType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ticketNumber => $composableBuilder(
    column: $table.ticketNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flightType => $composableBuilder(
    column: $table.flightType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passengerCategory => $composableBuilder(
    column: $table.passengerCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unaccompaniedMinor => $composableBuilder(
    column: $table.unaccompaniedMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuingAgent => $composableBuilder(
    column: $table.issuingAgent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commission => $composableBuilder(
    column: $table.commission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TicketsTableFilterComposer get originalTicketId {
    final $$TicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.originalTicketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableFilterComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flightSegmentsRefs(
    Expression<bool> Function($$FlightSegmentsTableFilterComposer f) f,
  ) {
    final $$FlightSegmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flightSegments,
      getReferencedColumn: (t) => t.ticketId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlightSegmentsTableFilterComposer(
            $db: $db,
            $table: $db.flightSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TicketsTableOrderingComposer
    extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableOrderingComposer({
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

  ColumnOrderings<String> get pnr => $composableBuilder(
    column: $table.pnr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transportType => $composableBuilder(
    column: $table.transportType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ticketNumber => $composableBuilder(
    column: $table.ticketNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flightType => $composableBuilder(
    column: $table.flightType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passengerCategory => $composableBuilder(
    column: $table.passengerCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unaccompaniedMinor => $composableBuilder(
    column: $table.unaccompaniedMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuingAgent => $composableBuilder(
    column: $table.issuingAgent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commission => $composableBuilder(
    column: $table.commission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TicketsTableOrderingComposer get originalTicketId {
    final $$TicketsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.originalTicketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableOrderingComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TicketsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pnr =>
      $composableBuilder(column: $table.pnr, builder: (column) => column);

  GeneratedColumn<DateTime> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transportType => $composableBuilder(
    column: $table.transportType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ticketNumber => $composableBuilder(
    column: $table.ticketNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flightType => $composableBuilder(
    column: $table.flightType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passengerCategory => $composableBuilder(
    column: $table.passengerCategory,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get unaccompaniedMinor => $composableBuilder(
    column: $table.unaccompaniedMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issuingAgent => $composableBuilder(
    column: $table.issuingAgent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commission => $composableBuilder(
    column: $table.commission,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TicketsTableAnnotationComposer get originalTicketId {
    final $$TicketsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.originalTicketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableAnnotationComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flightSegmentsRefs<T extends Object>(
    Expression<T> Function($$FlightSegmentsTableAnnotationComposer a) f,
  ) {
    final $$FlightSegmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flightSegments,
      getReferencedColumn: (t) => t.ticketId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlightSegmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.flightSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TicketsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TicketsTable,
          Ticket,
          $$TicketsTableFilterComposer,
          $$TicketsTableOrderingComposer,
          $$TicketsTableAnnotationComposer,
          $$TicketsTableCreateCompanionBuilder,
          $$TicketsTableUpdateCompanionBuilder,
          (Ticket, $$TicketsTableReferences),
          Ticket,
          PrefetchHooks Function({
            bool clientId,
            bool originalTicketId,
            bool flightSegmentsRefs,
          })
        > {
  $$TicketsTableTableManager(_$AppDatabase db, $TicketsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TicketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TicketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TicketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> pnr = const Value.absent(),
                Value<DateTime> emissionDate = const Value.absent(),
                Value<String> transportType = const Value.absent(),
                Value<String?> ticketNumber = const Value.absent(),
                Value<String?> flightType = const Value.absent(),
                Value<String?> passengerCategory = const Value.absent(),
                Value<bool?> unaccompaniedMinor = const Value.absent(),
                Value<String?> issuingAgent = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double?> commission = const Value.absent(),
                Value<int?> originalTicketId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TicketsCompanion(
                id: id,
                clientId: clientId,
                pnr: pnr,
                emissionDate: emissionDate,
                transportType: transportType,
                ticketNumber: ticketNumber,
                flightType: flightType,
                passengerCategory: passengerCategory,
                unaccompaniedMinor: unaccompaniedMinor,
                issuingAgent: issuingAgent,
                status: status,
                currency: currency,
                totalPrice: totalPrice,
                commission: commission,
                originalTicketId: originalTicketId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                required String pnr,
                required DateTime emissionDate,
                Value<String> transportType = const Value.absent(),
                Value<String?> ticketNumber = const Value.absent(),
                Value<String?> flightType = const Value.absent(),
                Value<String?> passengerCategory = const Value.absent(),
                Value<bool?> unaccompaniedMinor = const Value.absent(),
                Value<String?> issuingAgent = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String> currency = const Value.absent(),
                required double totalPrice,
                Value<double?> commission = const Value.absent(),
                Value<int?> originalTicketId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TicketsCompanion.insert(
                id: id,
                clientId: clientId,
                pnr: pnr,
                emissionDate: emissionDate,
                transportType: transportType,
                ticketNumber: ticketNumber,
                flightType: flightType,
                passengerCategory: passengerCategory,
                unaccompaniedMinor: unaccompaniedMinor,
                issuingAgent: issuingAgent,
                status: status,
                currency: currency,
                totalPrice: totalPrice,
                commission: commission,
                originalTicketId: originalTicketId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TicketsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                originalTicketId = false,
                flightSegmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (flightSegmentsRefs) db.flightSegments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$TicketsTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$TicketsTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (originalTicketId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.originalTicketId,
                                    referencedTable: $$TicketsTableReferences
                                        ._originalTicketIdTable(db),
                                    referencedColumn: $$TicketsTableReferences
                                        ._originalTicketIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (flightSegmentsRefs)
                        await $_getPrefetchedData<
                          Ticket,
                          $TicketsTable,
                          FlightSegment
                        >(
                          currentTable: table,
                          referencedTable: $$TicketsTableReferences
                              ._flightSegmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TicketsTableReferences(
                                db,
                                table,
                                p0,
                              ).flightSegmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ticketId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TicketsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TicketsTable,
      Ticket,
      $$TicketsTableFilterComposer,
      $$TicketsTableOrderingComposer,
      $$TicketsTableAnnotationComposer,
      $$TicketsTableCreateCompanionBuilder,
      $$TicketsTableUpdateCompanionBuilder,
      (Ticket, $$TicketsTableReferences),
      Ticket,
      PrefetchHooks Function({
        bool clientId,
        bool originalTicketId,
        bool flightSegmentsRefs,
      })
    >;
typedef $$FlightSegmentsTableCreateCompanionBuilder =
    FlightSegmentsCompanion Function({
      Value<int> id,
      required int ticketId,
      Value<String?> airlineCode,
      Value<String?> flightNumber,
      required String origin,
      required String destination,
      required DateTime departureDate,
      required DateTime arrivalDate,
      Value<String?> flightClass,
      Value<String?> stopover,
    });
typedef $$FlightSegmentsTableUpdateCompanionBuilder =
    FlightSegmentsCompanion Function({
      Value<int> id,
      Value<int> ticketId,
      Value<String?> airlineCode,
      Value<String?> flightNumber,
      Value<String> origin,
      Value<String> destination,
      Value<DateTime> departureDate,
      Value<DateTime> arrivalDate,
      Value<String?> flightClass,
      Value<String?> stopover,
    });

final class $$FlightSegmentsTableReferences
    extends BaseReferences<_$AppDatabase, $FlightSegmentsTable, FlightSegment> {
  $$FlightSegmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TicketsTable _ticketIdTable(_$AppDatabase db) =>
      db.tickets.createAlias(
        $_aliasNameGenerator(db.flightSegments.ticketId, db.tickets.id),
      );

  $$TicketsTableProcessedTableManager get ticketId {
    final $_column = $_itemColumn<int>('ticket_id')!;

    final manager = $$TicketsTableTableManager(
      $_db,
      $_db.tickets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ticketIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlightSegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $FlightSegmentsTable> {
  $$FlightSegmentsTableFilterComposer({
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

  ColumnFilters<String> get airlineCode => $composableBuilder(
    column: $table.airlineCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get departureDate => $composableBuilder(
    column: $table.departureDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get arrivalDate => $composableBuilder(
    column: $table.arrivalDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flightClass => $composableBuilder(
    column: $table.flightClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stopover => $composableBuilder(
    column: $table.stopover,
    builder: (column) => ColumnFilters(column),
  );

  $$TicketsTableFilterComposer get ticketId {
    final $$TicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableFilterComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlightSegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlightSegmentsTable> {
  $$FlightSegmentsTableOrderingComposer({
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

  ColumnOrderings<String> get airlineCode => $composableBuilder(
    column: $table.airlineCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get departureDate => $composableBuilder(
    column: $table.departureDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get arrivalDate => $composableBuilder(
    column: $table.arrivalDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flightClass => $composableBuilder(
    column: $table.flightClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stopover => $composableBuilder(
    column: $table.stopover,
    builder: (column) => ColumnOrderings(column),
  );

  $$TicketsTableOrderingComposer get ticketId {
    final $$TicketsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableOrderingComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlightSegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlightSegmentsTable> {
  $$FlightSegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get airlineCode => $composableBuilder(
    column: $table.airlineCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get departureDate => $composableBuilder(
    column: $table.departureDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get arrivalDate => $composableBuilder(
    column: $table.arrivalDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flightClass => $composableBuilder(
    column: $table.flightClass,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stopover =>
      $composableBuilder(column: $table.stopover, builder: (column) => column);

  $$TicketsTableAnnotationComposer get ticketId {
    final $$TicketsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.tickets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketsTableAnnotationComposer(
            $db: $db,
            $table: $db.tickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlightSegmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlightSegmentsTable,
          FlightSegment,
          $$FlightSegmentsTableFilterComposer,
          $$FlightSegmentsTableOrderingComposer,
          $$FlightSegmentsTableAnnotationComposer,
          $$FlightSegmentsTableCreateCompanionBuilder,
          $$FlightSegmentsTableUpdateCompanionBuilder,
          (FlightSegment, $$FlightSegmentsTableReferences),
          FlightSegment,
          PrefetchHooks Function({bool ticketId})
        > {
  $$FlightSegmentsTableTableManager(
    _$AppDatabase db,
    $FlightSegmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlightSegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlightSegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlightSegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ticketId = const Value.absent(),
                Value<String?> airlineCode = const Value.absent(),
                Value<String?> flightNumber = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String> destination = const Value.absent(),
                Value<DateTime> departureDate = const Value.absent(),
                Value<DateTime> arrivalDate = const Value.absent(),
                Value<String?> flightClass = const Value.absent(),
                Value<String?> stopover = const Value.absent(),
              }) => FlightSegmentsCompanion(
                id: id,
                ticketId: ticketId,
                airlineCode: airlineCode,
                flightNumber: flightNumber,
                origin: origin,
                destination: destination,
                departureDate: departureDate,
                arrivalDate: arrivalDate,
                flightClass: flightClass,
                stopover: stopover,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ticketId,
                Value<String?> airlineCode = const Value.absent(),
                Value<String?> flightNumber = const Value.absent(),
                required String origin,
                required String destination,
                required DateTime departureDate,
                required DateTime arrivalDate,
                Value<String?> flightClass = const Value.absent(),
                Value<String?> stopover = const Value.absent(),
              }) => FlightSegmentsCompanion.insert(
                id: id,
                ticketId: ticketId,
                airlineCode: airlineCode,
                flightNumber: flightNumber,
                origin: origin,
                destination: destination,
                departureDate: departureDate,
                arrivalDate: arrivalDate,
                flightClass: flightClass,
                stopover: stopover,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FlightSegmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ticketId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ticketId,
                                referencedTable: $$FlightSegmentsTableReferences
                                    ._ticketIdTable(db),
                                referencedColumn:
                                    $$FlightSegmentsTableReferences
                                        ._ticketIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FlightSegmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlightSegmentsTable,
      FlightSegment,
      $$FlightSegmentsTableFilterComposer,
      $$FlightSegmentsTableOrderingComposer,
      $$FlightSegmentsTableAnnotationComposer,
      $$FlightSegmentsTableCreateCompanionBuilder,
      $$FlightSegmentsTableUpdateCompanionBuilder,
      (FlightSegment, $$FlightSegmentsTableReferences),
      FlightSegment,
      PrefetchHooks Function({bool ticketId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$TicketsTableTableManager get tickets =>
      $$TicketsTableTableManager(_db, _db.tickets);
  $$FlightSegmentsTableTableManager get flightSegments =>
      $$FlightSegmentsTableTableManager(_db, _db.flightSegments);
}
