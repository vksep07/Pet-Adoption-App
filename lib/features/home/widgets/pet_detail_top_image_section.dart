import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/features/home/widgets/image_zoom_page.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';

class PetDetailTopImageSection extends StatefulWidget {
  const PetDetailTopImageSection({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  State<PetDetailTopImageSection> createState() =>
      _PetDetailTopImageSectionState();
}

class _PetDetailTopImageSectionState extends State<PetDetailTopImageSection> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageZoomPage(
              imageProvider: NetworkImage(widget.pet.album[_currentIndex]),
              bgColor: Colors.white,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.red,
        child: Stack(
          children: [
            SizedBox(
              height: screenHeight * 0.35,
              child: Hero(
                tag: widget.pet.location,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pet.album.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.pet.album[index],
                      fit: BoxFit.cover,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.space10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.pet.album.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space4),
                    height: AppSpacing.space8,
                    width: AppSpacing.space8,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == index ? Colors.white : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
