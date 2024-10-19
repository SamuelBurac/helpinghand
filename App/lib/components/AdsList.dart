import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityCard.dart';
import 'package:helping_hand/jobListingFiles/JobCard.dart';
import 'package:helping_hand/services/adState.dart';
import 'package:provider/provider.dart';
import 'package:helping_hand/services/models.dart';

class AdsList extends StatefulWidget {
  final List<ListItem> items;

   const AdsList({super.key, required this.items});

  @override
  _AdsListState createState() => _AdsListState();
}
class _AdsListState extends State<AdsList> {
  late List<ListItem> itemList;

  @override
  void initState() {
    super.initState();
    itemList = widget.items;

    // Add ads to the list
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then((status) {
      setState(() {
        itemList.insert(
          itemList.length,
          ListItem(
            bannerAd: BannerAd(
              adUnitId: adState.bannerAdUnitId,
              size: AdSize.mediumRectangle,
              request: const AdRequest(),
              listener: adState.bannerAdListener,
            )..load(),
          ),
        );

        if (itemList.length > 5) {
          for (int i = itemList.length; i > 0; i--) {
            if (i % 4 == 0) {
              itemList.insert(
                i,
                ListItem(
                  bannerAd: BannerAd(
                    adUnitId: adState.bannerAdUnitId,
                    size: AdSize.mediumRectangle,
                    request: const AdRequest(),
                    listener: adState.bannerAdListener,
                  )..load(),
                ),
              );
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        if (item.jobPosting != null) {
          return JobCard(jobPosting: item.jobPosting!);
        } else if (item.availabilityPosting != null) {
          return AvailabilityCard(availabilityPosting: item.availabilityPosting!);
        } else if (item.bannerAd != null) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
            alignment: Alignment.center,
            width: item.bannerAd!.size.width.toDouble(),
            height: 250,
            child: AdWidget(ad: item.bannerAd!),
          );
        } else {
          return SizedBox.shrink(); // Handle unexpected types gracefully
        }
      },
    );
  }
}



class ListItem {
  final JobPosting? jobPosting;
  final AvailabilityPosting? availabilityPosting;
  final BannerAd? bannerAd;

  ListItem({this.availabilityPosting, this.jobPosting, this.bannerAd});
}




