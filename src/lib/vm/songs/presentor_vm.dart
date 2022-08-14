import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/base/book.dart';
import '../../model/base/song.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../util/constants/app_constants.dart';
import '../../util/constants/utilities.dart';
import '../../widget/general/toast.dart';

@injectable
class PresentorVm with ChangeNotifierEx {
  late final PresentorNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository db;

  PresentorVm(this.db, this.localStorage);

  List<Book>? books;
  Book? book;
  Song? song;
  bool isBusy = false, isLiked = true, hasChorus = false;

  String songContent = '';
  int curStanza = 0, curSong = 0;
  List<String> songVerses = [], verseInfos = [], verseTexts = [];

  IconData likeIcon = Icons.favorite_border;

  Future<void> init(PresentorNavigator screenNavigator) async {
    navigator = screenNavigator;
  }

  Future<void> loadViewer() async {
    books!.retainWhere((item) => item.bookNo == song!.book);
    book = books![0];

    isLiked = song!.liked!;
    likeIcon = isLiked ? Icons.favorite : Icons.favorite_border;
    songVerses = song!.content!.split("##");
    int verseCount = songVerses.length;

    if (song!.content!.contains("CHORUS")) {
      hasChorus = true;
    } else {
      hasChorus = false;
    }

    if (hasChorus) {
      String chorus = songVerses[1].toString().replaceAll("CHORUS#", "");

      verseInfos.add("1");
      verseInfos.add("C");
      verseTexts.add(songVerses[0]);
      verseTexts.add(chorus);

      for (int i = 2; i < verseCount; i++) {
        verseInfos.add(i.toString());
        verseInfos.add("C");
        verseTexts.add(songVerses[i]);
        verseTexts.add(chorus);
      }
    } else {
      for (int i = 0; i < verseCount; i++) {
        verseInfos.add((i + 1).toString());
        verseTexts.add(songVerses[i]);
      }
    }
  }

  Future<void> popupActions(int value) async {
    switch (value) {
      case 0:
        await copySong();
        break;

      case 1:
        await copySong();
        break;
      case 2:
        break;
    }
  }

  Future<void> copySong() async {
    String songText = song!.content!.replaceAll("#", "\n");
    await Clipboard.setData(ClipboardData(
      text: '${songItemTitle(song!.songNo!, song!.title!)}\n\n$songText',
    ));
    showToast(
      text: '${song!.title} ${AppConstants.songCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> shareSong() async {
    String songText = song!.content!.replaceAll("#", "\n");
    await Share.share(
      '${songItemTitle(song!.songNo!, song!.title!)}\n\n$songText',
      subject: AppConstants.shareVerse,
    );
    showToast(
      text: AppConstants.verseReadyShare,
      state: ToastStates.success,
    );
  }

  Future<void> likeSong() async {
    isLiked = !isLiked;
    song!.liked = isLiked;
    await db.editSong(song!);
    likeIcon = isLiked ? Icons.favorite : Icons.favorite_border;
    if (isLiked) {
      showToast(
        text: '${song!.title} ${AppConstants.songLiked}',
        state: ToastStates.success,
      );
    }
    notifyListeners();
  }

  Future<void> copyVerse(String lyrics) async {
    await Clipboard.setData(
      ClipboardData(
        text: '${lyrics.replaceAll("#", "\n")}\n\n'
            '${songItemTitle(song!.songNo!, song!.title!)},\n'
            '${book!.title}',
      ),
    );
    showToast(
      text: AppConstants.verseCopied,
      state: ToastStates.success,
    );
  }

  Future<void> shareVerse(String lyrics) async {
    await Share.share(
      '${lyrics.replaceAll("#", "\n")}\n\n'
      '${songItemTitle(song!.songNo!, song!.title!)},\n'
      '${book!.title}',
      subject: AppConstants.shareVerse,
    );
    showToast(
      text: AppConstants.verseReadyShare,
      state: ToastStates.success,
    );
  }

  void onBackPressed() => navigator.goBack<void>();
}

abstract class PresentorNavigator implements BackNavigator {
  void goToHome();

  void goToSelection();
}