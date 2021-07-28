// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:publicart/src/utils/colors.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final GetStorage box = GetStorage();

  void _onIntroEnd(context) {
    box.write('first', false);
    Get.to(() => HomeScreen());
  }

  Widget _buildFullscrenImage(BuildContext context, String introIndex) {
    return Image.asset(
      'assets/images/intro$introIndex.png',
      fit: BoxFit.cover,
      height: context.height,
      width: context.width,
      alignment: Alignment.center,
    );
  }

  Widget _textCloud(String title, String body, TextStyle headline,
      TextStyle bodytext, double height, double width, Widget rt) {
    return Container(
      height: height / 2,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.05),
        child: title != ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, textAlign: TextAlign.right, style: headline),
                  SizedBox(height: height * 0.05),
                  Text(body, textAlign: TextAlign.start, style: bodytext),
                ],
              )
            : rt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.headline1!;
    final bodytext = Theme.of(context).textTheme.bodyText1!;
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: '',
          bodyWidget: _textCloud(
            'Привет!',
            'Это приложение создано с целью популяризации стрит-арта. Открывай карту и ищи граффити в своем городе!',
            headline,
            bodytext,
            context.height * 0.4,
            context.width * 0.9,
            const SizedBox(),
          ),
          image: _buildFullscrenImage(context, '1'),
          decoration: const PageDecoration(
            // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 3,
            imageFlex: 1,
          ),
        ),
        PageViewModel(
          title: '',
          bodyWidget: _textCloud(
            '',
            '',
            headline,
            bodytext,
            context.height * 0.53,
            context.width * 0.9,
            RichText(
                text: TextSpan(
              style: bodytext,
              children: [
                TextSpan(
                    text:
                        'Весь сезон мы будем обновлять приложение, чтобы ты смог найти на карте новые стрит-арт-работы, оживлял их с помощью '),
                TextSpan(text: 'дополненной реальности ', style: headline),
                TextSpan(text: 'и даже мог прослушать '),
                TextSpan(text: 'аудиогид ', style: headline),
                TextSpan(
                    text:
                        'от любимого художника.\n\nВзгляни на свой город с другой стороны!')
              ],
            )),
          ),
          image: _buildFullscrenImage(context, '2'),
          decoration: PageDecoration(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 3,
            imageFlex: 1,
          ),
        ),
        PageViewModel(
          title: '',
          bodyWidget: _textCloud(
            '',
            '',
            headline,
            bodytext,
            context.height * 0.53,
            context.width * 0.9,
            RichText(
                text: TextSpan(
              style: bodytext,
              children: [
                TextSpan(
                    text:
                        'Мы открыты к сотрудничеству! По вопросам добавления работ/внедрения дополненной реальности пиши на почту hey@pushkeen.ru (с темой: '),
                TextSpan(text: 'хочу в Public Art', style: headline),
                TextSpan(
                    text:
                        ').\n\nТакже мы будем рады Вашим советам по развитию проекта.')
              ],
            )),
          ),
          image: _buildFullscrenImage(context, '3'),
          decoration: const PageDecoration(
            // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 3,
            imageFlex: 1,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      skip: const Text('Пропустить',
          style:
              TextStyle(color: Color(0xFF3A99AF), fontWeight: FontWeight.w600)),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,
      next: const Icon(Icons.arrow_forward),
      done: const Text('Готово',
          style:
              TextStyle(color: Color(0xFF3A99AF), fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(context.height * 0.03),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      // dotsFlex: 3,
      nextColor: const Color(0xFF3A99AF),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        spacing: EdgeInsets.symmetric(horizontal: context.width * 0.01),
        color: Color(0xFFEBEDEE),
        activeColor: Color(0xFF3A99AF),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color(0xFF1C313A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MAP'),
      ),
    );
  }
}
