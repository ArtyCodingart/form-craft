# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

## [v0.0.2] - 2025-05-13

### Added

- Int validator: `lt` rule
- Int validator: `lte` rule
- Int validator: `gt` rule
- Int validator: `gte` rule
- Int validator: `positive` rule
- Int validator: `nonNegative` rule
- Int validator: `negative` rule
- Int validator: `nonPositive` rule
- Int validator: `multipleOf` rule
- Decimal validator: `lt` rule
- Decimal validator: `lte` rule
- Decimal validator: `gt` rule
- Decimal validator: `gte` rule
- Decimal validator: `positive` rule
- Decimal validator: `nonNegative` rule
- Decimal validator: `negative` rule
- Decimal validator: `nonPositive` rule
- Decimal validator: `multipleOf` rule
- String validator: `trimmed` rule
- String validator: `cuid` rule
- String validator: `cuid2` rule
- String validator: `ulid` rule
- String validator: `uuid` rule
- String validator: `nanoId` rule
- String validator: `ipv4` rule
- String validator: `ipv6` rule
- String validator: `cidr` rule
- String validator: `ip` rule
- String validator: `date` rule

### Removed

- Int validator: `min` rule
- Int validator: `max` rule
- Decimal validator: `min` rule
- Decimal validator: `max` rule

### Changed

- String validator: renamed rule `isNotEmpty` -> `notEmpty`
- String validator: renamed rule `equalTo` -> `equals`
- Boolean validator: renamed rule `isTrue` -> `checked`
