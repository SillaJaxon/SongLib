part of '../home_screen.dart';

/// Tab screen for searches
// ignore: must_be_immutable
class SearchTab extends StatelessWidget {
  final HomeVm homeVm;
  SearchTab({Key? key, required this.homeVm}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    var titleContainer = homeVm.isBusy
        ? PageTitle(label: AppConstants.appTitle, size: size)
        : homeVm.songs!.isNotEmpty
            ? PageSearch(
                label: AppConstants.appTitle,
                size: size,
                onTap: () async {
                  await showSearch(
                    context: context,
                    delegate: SearchSongs(
                      context,
                      homeVm,
                      size!.height,
                      homeVm.songs!,
                    ),
                  );
                },
              )
            : PageTitle(label: AppConstants.appTitle, size: size);
    var booksContainer = SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(5),
        itemBuilder: (context, index) {
          final Book book = homeVm.books![index];
          return SongBook(
            book: book,
            height: size!.height,
            onTap: () => homeVm.selectSongbook(book.bookNo!),
          );
        },
        itemCount: homeVm.books!.length,
      ),
    );
    var listContainer = ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: homeVm.filtered!.length,
      padding: EdgeInsets.only(
        left: size!.height * 0.0082,
        right: size!.height * 0.0082,
      ),
      itemBuilder: (context, index) {
        final SongExt song = homeVm.filtered![index];
        return ContextMenuRegion(
          contextMenu: GenericContextMenu(
            buttonConfigs: [
              ContextMenuButtonConfig(
                AppConstants.likeSong,
                icon: Icon(
                  song.liked! ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                ),
                onPressed: () => homeVm.likeSong(song),
              ),
              ContextMenuButtonConfig(
                AppConstants.copySong,
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () => homeVm.copySong(song),
              ),
              ContextMenuButtonConfig(
                AppConstants.shareSong,
                icon: const Icon(Icons.share, size: 20),
                onPressed: () => homeVm.shareSong(song),
              ),
              ContextMenuButtonConfig(
                AppConstants.editSong,
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => homeVm.openEditor(song: song),
              ),
              ContextMenuButtonConfig(
                AppConstants.addtoList,
                icon: const Icon(Icons.add, size: 20),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return ListViewPopup(song: song);
                  },
                ),
              ),
            ],
          ),
          child: SongItem(
            song: song,
            height: size!.height,
            onTap: () => homeVm.openPresentor(song: song),
          ),
        );
      },
    );

    var mainContainer = Container(
      margin: EdgeInsets.only(top: size!.height * 0.0952),
      height: size!.height * 0.835,
      child: SingleChildScrollView(
        child: Column(
          children: [
            homeVm.books!.isNotEmpty ? booksContainer : Container(),
            SizedBox(
              child: homeVm.isBusy
                  ? const ListLoading()
                  : homeVm.songs!.isNotEmpty
                      ? listContainer
                      : const NoDataToShow(
                          title: AppConstants.itsEmptyHere,
                          description: AppConstants.itsEmptyHereBody,
                        ),
            ),
          ],
        ),
      ),
    );
    
    return Scaffold(
      body: ContextMenuOverlay(
        cardBuilder: (_, children) => Container(
          decoration: const BoxDecoration(
            color: ThemeColors.accent,
            boxShadow: [BoxShadow(blurRadius: 5)],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(children: children),
        ),
        child: Container(
          height: size!.height,
          padding: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, ThemeColors.accent, Colors.black],
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              mainContainer,
              titleContainer,
            ],
          ),
        ),
      ),
    );
  }
}
