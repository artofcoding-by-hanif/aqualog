import '../entities/invertebrate.dart';

/// Invertebrate repository interface
abstract class InvertebrateRepository {
  /// Get all invertebrates for a tank
  Future<List<InvertebrateEntity>> getInvertebratesForTank(int tankId);

  /// Get an invertebrate by ID
  Future<InvertebrateEntity?> getInvertebrateById(int id);

  /// Add a new invertebrate
  Future<int> addInvertebrate(InvertebrateEntity invertebrate);

  /// Update an existing invertebrate
  Future<void> updateInvertebrate(InvertebrateEntity invertebrate);

  /// Delete an invertebrate
  Future<void> deleteInvertebrate(int id);

  /// Delete all invertebrates for a tank
  Future<void> deleteInvertebratesForTank(int tankId);

  /// Watch all invertebrates for a tank (reactive stream)
  Stream<List<InvertebrateEntity>> watchInvertebratesForTank(int tankId);

  /// Get count of alive invertebrates for a tank
  Future<int> getAliveInvertebrateCount(int tankId);
}

