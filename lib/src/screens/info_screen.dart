import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.headline1!;
    final bodytext = Theme.of(context).textTheme.bodyText1!;
    final ctxH = context.height;
    final ctxW = context.width;
    return Material(
      type: MaterialType.canvas,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
              height: ctxH,
              width: ctxW,
              child: Image.asset(
                'assets/images/intro3.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          FittedBox(
            alignment: Alignment.center,
            child: Container(
              width: ctxW * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white70,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ctxW * 0.05, vertical: ctxH * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      style: bodytext,
                      children: [
                        const TextSpan(text: 'Ищи на '),
                        TextSpan(text: 'карте ', style: headline),
                        const TextSpan(
                            text:
                                'новые стрит-арт-работы, оживляй их с помощью '),
                        TextSpan(
                            text: 'дополненной реальности ', style: headline),
                        const TextSpan(text: 'и слушай '),
                        TextSpan(text: 'аудиогид ', style: headline),
                        const TextSpan(text: 'от любимого художника.\n\n'),
                        const TextSpan(
                            text:
                                'Взгляни на свой город с другой стороны!\n\n'),
                        const TextSpan(
                            text:
                                'Мы открыты к сотрудничеству! По вопросам добавления работ/внедрения дополненной реальности пиши на почту hey@pushkeen.ru (с темой: хочу в Public Art).\n\n'),
                        const TextSpan(
                            text:
                                'Также мы будем рады Вашим советам по развитию проекта.\n\n'),
                      ],
                    )),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Политика конфиденциальности',
                        style: bodytext.copyWith(
                          color: const Color(0xFF2B4854).withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ctxW * 0.05, vertical: ctxH * 0.02),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset('assets/svg/arrow_back.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
