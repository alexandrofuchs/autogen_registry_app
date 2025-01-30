part of 'registry_groups_page.dart';

mixin RegistryGroupsWidgets on CommonWidgets {
  Widget groupWidget(BuildContext context, RegistryGroupsProvider provider, int groupIndex) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              AppRouter.route(
                  HomeWorflow.openedRegistryGroupPage(
                      provider.groups[groupIndex]),
                  transition: RouteTransition.rightToLeft));
        },
        child: Container(
            margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
            decoration: const BoxDecoration(
              color: AppColors.primaryColorDark,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(25)),
              border: Border(
                  top: BorderSide(color: AppColors.backgroundColor),
                  bottom: BorderSide(color: AppColors.backgroundColor)),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(child: titleDot(provider.groups[groupIndex])),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.secundaryColor,
                  ),
                ),
              ],
            )),
      );

  Widget loadedGroups(RegistryGroupsProvider provider) => Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(15),
        child: provider.groups.isEmpty
            ? Center(
                child: Container(
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.primaryColorLight, width: 3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),topRight: Radius.circular(5),
                      topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
                  ),
                  color: AppColors.primaryColorDark),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Nenhum grupo criado',
                    style: AppTextStyles.labelStyleLarge
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: provider.groups.length,
                itemBuilder: (context, groupIndex) =>
                    groupWidget(context, provider, groupIndex),
              ),
      );
}