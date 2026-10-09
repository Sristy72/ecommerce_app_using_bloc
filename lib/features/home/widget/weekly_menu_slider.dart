import 'package:ecommerce_app_using_bloc/features/home/model/weekly_menu_model.dart';
import 'package:flutter/cupertino.dart';

class WeeklyMenuSlider extends StatelessWidget {
  final List<WeeklyMenu> weeklyMenus;

  const WeeklyMenuSlider({
    super.key,
    required this.weeklyMenus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: weeklyMenus.length,
        itemBuilder: (context, index) {
          final dayMenu = weeklyMenus[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF77A9EA),
                  Color(0xFF6B8FEE),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayMenu.day,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: dayMenu.items.isEmpty
                      ? const Center(
                          child: Text(
                            'No menu available for this day',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dayMenu.items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = dayMenu.items[itemIndex];

                            return Container(
                              width: 130,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF713E18),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    '৳${item.price}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}