import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/widgets/new_registry_widget.dart';

class RegistriesPage extends StatefulWidget {
  const RegistriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistriesPageState();
}

class _RegistriesPageState extends State<RegistriesPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets, NewRegistryWidget {
  @override
  void initState() {
    selectedFileType = ValueNotifier(0);
    super.initState();
  }

  @override
  dispose() {
    selectedFileType.dispose();
    super.dispose();
  }

  Widget footer() => GestureDetector(
        onTap: () {
          openNewRegistry(context);
        },
        child: addNewFileButtomHeader(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: searchAppBarBottom(),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: footer(),
      body: Column(
        children: [
          filterBar(),
          divider(),
          ListView(
            shrinkWrap: true,
            children: [
              item(Icons.picture_as_pdf, 'Um arquivo pdf.'),
              item(Icons.video_camera_back, 'Um outro arquivo em video.'),
              item(Icons.image, 'Um outro arquivo em imagem.'),
            ],
          ),
        ],
      ),
    );
  }
}
