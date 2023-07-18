import 'package:bhagvat_geeta/controller/chapter_controller.dart';
import 'package:bhagvat_geeta/controller/language_controller.dart';
import 'package:bhagvat_geeta/controller/verses_controller.dart';
import 'package:bhagvat_geeta/model/chapter_model.dart';
import 'package:bhagvat_geeta/model/verses_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChDetailScreen extends StatelessWidget {
  const ChDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int cIndex = ModalRoute.of(context)!.settings.arguments as int;

    double h = MediaQuery.of(context).size.height;

    TextStyle largeTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    TextStyle summaryTextStyle = const TextStyle(fontSize: 16);

    dynamic languagePro = Provider.of<LanguageController>(context).isHindi;

    return Consumer<ChapterController>(builder: (context, chProvider, child) {
      ChapterModel pro = chProvider.allChapter[cIndex];

      return Scaffold(
        appBar: AppBar(
          title: Text(languagePro
              ? "अध्याय ${pro.chapterNumber} ${pro.name}"
              : " ${pro.chapterNumber}. ${pro.nameTranslation}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: chProvider.allChapter.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: chProvider.images[cIndex]
                                .map(
                                  (e) => Container(
                                    height: 250,
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          e,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayCurve: Curves.easeOut,
                              onPageChanged: (index, reason) {
                                chProvider.changeCarouselIndex(index: index);
                              },
                            ),
                          ),
                          Center(
                            child: DotsIndicator(
                              dotsCount: chProvider.images[cIndex].length,
                              position: chProvider.currentIndex,
                              decorator: const DotsDecorator(
                                  activeColor: Colors.deepOrangeAccent),
                            ),
                          ),
                          SizedBox(height: h * 0.01),
                          Center(
                            child: Text(
                              languagePro ? pro.name : pro.nameTranslation,
                              style: largeTextStyle,
                            ),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            languagePro ? "सारांश:-" : "Summary:- ",
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            languagePro
                                ? "                 ${pro.chapterSummaryHindi}"
                                : "                 ${pro.chapterSummary}",
                            style: summaryTextStyle,
                          ),
                          SizedBox(height: h * 0.01),
                        ],
                      ),
                      Column(
                        children: [
                          Consumer<VersesController>(
                            builder: (context, verseProvider, child) {
                              return verseProvider.allVerse.isNotEmpty
                                  ? SizedBox(
                                      height: (h * 0.09) *
                                          (chProvider.allChapter[cIndex]
                                                  .versesCount +
                                              5),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: chProvider
                                            .allChapter[cIndex].versesCount,
                                        itemBuilder: (context, index) {
                                          VerseModel vData =
                                              verseProvider.allVerse[index];
                                          return Card(
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    'verse_detail_screen',
                                                    arguments: index);
                                              },
                                              leading: const CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "https://t4.ftcdn.net/jpg/03/86/49/47/360_F_386494724_VFDRWekKzg2dTnHe4eRcKWayvzLnYyZt.jpg"),
                                              ),
                                              title: Text(languagePro
                                                  ? "श्लोक ${vData.verseNumber}"
                                                  : vData.title),
                                              subtitle: Text(languagePro
                                                  ? "श्लोक पढ़ने के लिए क्लिक करें"
                                                  : "Read shloka here"),
                                              trailing: const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
