

import 'package:jmate/constants/image_strings.dart';
import 'package:jmate/constants/text_strings.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: onBoardingTitle1,
    image: onBoardingImage1,
    desc: onBoardingSubTitle1,
  ),
  OnboardingContents(
    title: onBoardingTitle2,
    image: onBoardingImage2,
    desc: onBoardingSubTitle2,
  ),
  OnboardingContents(
    title: onBoardingTitle3,
    image: onBoardingImage3,
    desc: onBoardingSubTitle3,
  ),
];
