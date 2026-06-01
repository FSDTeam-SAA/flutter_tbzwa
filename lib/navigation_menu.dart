import 'package:flutter/material.dart';
import 'package:flutter_tbzwa/features/community/screens/community_screen.dart';
import 'package:flutter_tbzwa/features/learn/screens/learn_screen.dart';
import 'package:flutter_tbzwa/features/profile/screens/profile_screen.dart';
import 'package:flutter_tbzwa/features/voice_room/screens/voice_room.dart';
import 'package:get/get.dart';

import 'core/constants/assest_const.dart' hide Icons;
import 'core/utils/app_svg.dart';
import 'features/home/screens/home_screen.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFF1DB),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      bottomNavigationBar: Obx(
            () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E8),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(controller.items.length, (index) {
              final item = controller.items[index];
              final isSelected = controller.selectedIndex.value == index;

              return GestureDetector(
                onTap: () => controller.selectedIndex.value = index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOut,

                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 18 : 14,
                    vertical: isSelected ? 10 : 8,
                  ),

                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1B76FF).withOpacity(0.82)
                        : const Color(0xFFE89208).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),

                  child: Row(
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1 : 1.0,
                        duration: const Duration(milliseconds: 220),
                        child: AppSvg(
                          asset: item['icon'],
                          height: 22,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF713C1B),
                        ),
                      ),

                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item['label'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Map<String, dynamic>> items = [
    {'icon': NabIcon.home, 'label': 'Home'},
    {'icon': NabIcon.learn, 'label': 'Learn'},
    {'icon': NabIcon.community, 'label': 'Community'},
    {'icon': NabIcon.voiceRoom, 'label': 'Voice Room'},
    {'icon': NabIcon.profile, 'label': 'Profile'},
  ];

  final List<Widget> screens = [
    const HomeScreen(),
    LearnScreen(),
    CommunityScreen(),
    VoiceRoom(),
    ProfileScreen()
  ];
}
