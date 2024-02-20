// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServiceEntity _$ServiceEntityFromJson(Map<String, dynamic> json) {
  return _ServiceEntity.fromJson(json);
}

/// @nodoc
mixin _$ServiceEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double? get priceAfterCouponApplied => throw _privateConstructorUsedError;
  List<RideOptionEntity> get rideOptions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceEntityCopyWith<ServiceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceEntityCopyWith<$Res> {
  factory $ServiceEntityCopyWith(
          ServiceEntity value, $Res Function(ServiceEntity) then) =
      _$ServiceEntityCopyWithImpl<$Res, ServiceEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String imageUrl,
      int? capacity,
      double price,
      double? priceAfterCouponApplied,
      List<RideOptionEntity> rideOptions});
}

/// @nodoc
class _$ServiceEntityCopyWithImpl<$Res, $Val extends ServiceEntity>
    implements $ServiceEntityCopyWith<$Res> {
  _$ServiceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = null,
    Object? capacity = freezed,
    Object? price = null,
    Object? priceAfterCouponApplied = freezed,
    Object? rideOptions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceAfterCouponApplied: freezed == priceAfterCouponApplied
          ? _value.priceAfterCouponApplied
          : priceAfterCouponApplied // ignore: cast_nullable_to_non_nullable
              as double?,
      rideOptions: null == rideOptions
          ? _value.rideOptions
          : rideOptions // ignore: cast_nullable_to_non_nullable
              as List<RideOptionEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceEntityImplCopyWith<$Res>
    implements $ServiceEntityCopyWith<$Res> {
  factory _$$ServiceEntityImplCopyWith(
          _$ServiceEntityImpl value, $Res Function(_$ServiceEntityImpl) then) =
      __$$ServiceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String imageUrl,
      int? capacity,
      double price,
      double? priceAfterCouponApplied,
      List<RideOptionEntity> rideOptions});
}

/// @nodoc
class __$$ServiceEntityImplCopyWithImpl<$Res>
    extends _$ServiceEntityCopyWithImpl<$Res, _$ServiceEntityImpl>
    implements _$$ServiceEntityImplCopyWith<$Res> {
  __$$ServiceEntityImplCopyWithImpl(
      _$ServiceEntityImpl _value, $Res Function(_$ServiceEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = null,
    Object? capacity = freezed,
    Object? price = null,
    Object? priceAfterCouponApplied = freezed,
    Object? rideOptions = null,
  }) {
    return _then(_$ServiceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceAfterCouponApplied: freezed == priceAfterCouponApplied
          ? _value.priceAfterCouponApplied
          : priceAfterCouponApplied // ignore: cast_nullable_to_non_nullable
              as double?,
      rideOptions: null == rideOptions
          ? _value._rideOptions
          : rideOptions // ignore: cast_nullable_to_non_nullable
              as List<RideOptionEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceEntityImpl implements _ServiceEntity {
  const _$ServiceEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.capacity,
      required this.price,
      required this.priceAfterCouponApplied,
      required final List<RideOptionEntity> rideOptions})
      : _rideOptions = rideOptions;

  factory _$ServiceEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String imageUrl;
  @override
  final int? capacity;
  @override
  final double price;
  @override
  final double? priceAfterCouponApplied;
  final List<RideOptionEntity> _rideOptions;
  @override
  List<RideOptionEntity> get rideOptions {
    if (_rideOptions is EqualUnmodifiableListView) return _rideOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rideOptions);
  }

  @override
  String toString() {
    return 'ServiceEntity(id: $id, name: $name, description: $description, imageUrl: $imageUrl, capacity: $capacity, price: $price, priceAfterCouponApplied: $priceAfterCouponApplied, rideOptions: $rideOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(
                    other.priceAfterCouponApplied, priceAfterCouponApplied) ||
                other.priceAfterCouponApplied == priceAfterCouponApplied) &&
            const DeepCollectionEquality()
                .equals(other._rideOptions, _rideOptions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      capacity,
      price,
      priceAfterCouponApplied,
      const DeepCollectionEquality().hash(_rideOptions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceEntityImplCopyWith<_$ServiceEntityImpl> get copyWith =>
      __$$ServiceEntityImplCopyWithImpl<_$ServiceEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceEntityImplToJson(
      this,
    );
  }
}

abstract class _ServiceEntity implements ServiceEntity {
  const factory _ServiceEntity(
      {required final String id,
      required final String name,
      required final String? description,
      required final String imageUrl,
      required final int? capacity,
      required final double price,
      required final double? priceAfterCouponApplied,
      required final List<RideOptionEntity> rideOptions}) = _$ServiceEntityImpl;

  factory _ServiceEntity.fromJson(Map<String, dynamic> json) =
      _$ServiceEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get imageUrl;
  @override
  int? get capacity;
  @override
  double get price;
  @override
  double? get priceAfterCouponApplied;
  @override
  List<RideOptionEntity> get rideOptions;
  @override
  @JsonKey(ignore: true)
  _$$ServiceEntityImplCopyWith<_$ServiceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
