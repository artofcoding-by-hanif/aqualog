import 'dart:io';

import 'package:aqualog/core/backup/backup_service.dart';
import 'package:aqualog/core/database/database_provider.dart';
import 'package:aqualog/core/storage/local_storage.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakePathProvider extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  _FakePathProvider(this.docs, this.tmp);

  String docs;
  final String tmp;

  @override
  Future<String?> getApplicationDocumentsPath() async => docs;

  @override
  Future<String?> getTemporaryPath() async => tmp;
}

void main() {
  late Directory root;
  late _FakePathProvider paths;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    root = await Directory.systemTemp.createTemp('aqualog_backup_test');
    final tmp = Directory('${root.path}/tmp')..createSync();
    final docs = Directory('${root.path}/docsA')..createSync();
    paths = _FakePathProvider(docs.path, tmp.path);
    PathProviderPlatform.instance = paths;
  });

  tearDown(() => root.delete(recursive: true));

  test('backup from one install restores into another', () async {
    // Install A: one tank with a photo on disk
    final dbA = AppDatabase(NativeDatabase(File('${root.path}/a.sqlite')));
    final tankId = await dbA.insertTank(
      TanksCompanion.insert(
        name: 'Betta tank',
        tankType: TankType.freshwater,
        volumeLiters: 40,
      ),
    );
    final photo = File('${paths.docs}/tank_images/$tankId/1.jpg')
      ..createSync(recursive: true)
      ..writeAsBytesSync([1, 2, 3]);
    await dbA.insertTankImage(
      TankImagesCompanion.insert(tankId: tankId, imagePath: photo.path),
    );

    final zip = await BackupService(dbA, LocalStorage.instance).createBackup();
    await dbA.close();

    // Install B: different documents folder and some data to be replaced
    paths.docs = (Directory('${root.path}/docsB')..createSync()).path;
    final dbB = AppDatabase(NativeDatabase(File('${root.path}/b.sqlite')));
    await dbB.insertTank(
      TanksCompanion.insert(
        name: 'Old tank',
        tankType: TankType.planted,
        volumeLiters: 10,
      ),
    );

    final summary = await BackupService(dbB, LocalStorage.instance)
        .restoreBackup(zip);

    expect(summary.tanks, 1);
    expect(summary.images, 1);

    final tanks = await dbB.getAllTanks();
    expect(tanks.single.name, 'Betta tank');

    final image = (await dbB.getImagesForTank(tanks.single.id)).single;
    expect(image.imagePath, '${paths.docs}/tank_images/$tankId/1.jpg');
    expect(File(image.imagePath).readAsBytesSync(), [1, 2, 3]);

    // The replaced data was kept as a safety copy
    expect(
      File('${paths.docs}/auto_backups/pre_restore.zip').existsSync(),
      isTrue,
    );

    await dbB.close();
  });

  test('rejects files that are not Aqualog backups', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final bogus = File('${root.path}/bogus.zip')..writeAsStringSync('nope');

    expect(
      () => BackupService(db, LocalStorage.instance).restoreBackup(bogus),
      throwsA(isA<BackupException>()),
    );
    await db.close();
  });
}
