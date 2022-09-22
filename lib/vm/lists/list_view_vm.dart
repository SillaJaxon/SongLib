import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/listedext.dart';
import '../../model/base/songext.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../home/home_vm.dart';

@injectable
class ListViewVm with ChangeNotifierEx {
  late final ListViewNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  ListViewVm(this.dbRepo, this.localStorage);

  HomeVm? homeVm;
  Listed? listed;
  List<SongExt>? songs = [];
  List<ListedExt>? listeds = [];

  bool isBusy = false;

  Future<void> init(ListViewNavigator screenNavigator) async {
    navigator = screenNavigator;
    homeVm = GetIt.instance<HomeVm>();
    listed = localStorage.listed;
    await fetchData();
  }

  /// Get the data from the DB
  Future<void> fetchData() async {
    isBusy = true;
    notifyListeners();

    try {
      songs = await dbRepo.fetchSongs();
      listeds = await dbRepo.fetchListedSongs(listed!.id!);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }

    isBusy = false;
    notifyListeners();
  }

  void openPresentor({SongExt? song, Draft? draft}) async {
    if (song != null) {
      localStorage.song = song;
      localStorage.draft = null;
    } else if (draft != null) {
      localStorage.song = null;
      localStorage.draft = draft;
    }
    navigator.goToPresentor();
  }

  Future<void> confirmDelete(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Just a Minute',
          style: TextStyle(fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to delete the song list: ${listed!.title}?',
          style: const TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              dbRepo.deleteListed(listed!);
              onBackPressed();
            },
            child: const Text("DELETE"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
        ],
      ),
    );
  }

  void onBackPressed() => navigator.goBack<void>();
}

abstract class ListViewNavigator implements BackNavigator {
  void goToPresentor();
}