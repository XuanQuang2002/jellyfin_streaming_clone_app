import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellyfin_streaming_clone_app/app.dart';
import 'package:jellyfin_streaming_clone_app/core/storage/hive_storage.dart';
import 'package:media_kit/media_kit.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MediaKit.ensureInitialized();

  await Hive.initFlutter();
  await HiveStorage.registerAdapters();
  await HiveStorage.openBoxes();
  runApp(ProviderScope(child: JellyfinApp()));
}
