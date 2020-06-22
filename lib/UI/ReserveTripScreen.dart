import 'package:booktrip/UI/Alert.dart';
import 'package:booktrip/UI/UtiityMethods.dart';
import 'package:booktrip/model/TripModel.dart';
import 'package:booktrip/presenter/TripPresenter.dart';
import 'package:booktrip/view/TripView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ReserveTripScreen extends StatefulWidget {
  @override
  _ReserveTripScreenState createState() => _ReserveTripScreenState();
}

class _ReserveTripScreenState extends State<ReserveTripScreen>
    implements TripView {
  TripPresenter _tripPresenter;
  bool _isPresenterCalled = false;
  bool _isFavorite = false;
  TripModel _tripData;
  int _imgIndex = 0;
  var _currentImgNotifier = ValueNotifier<int>(0);
  SingleActionAlert _alert;

  @override
  Widget build(BuildContext context) {
    loadDataFromAPI();
    return Scaffold(
        body: Center(
      child: (_tripData != null)
          ? ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    drawImageWidget(),
                    drawTopIconsWidget(),
                    drawCircleImageIndicator()
                  ],
                ),
                getInterestTextWidget(),
                getDateWidget(),
                getAddressWidget(),
                Divider(thickness: 1.5, endIndent: 5, indent: 5),
                drawTrainerInfoWidget(),
                drawOccasionDetailWidget(),
                SizedBox(height: 20),
                drawButtonWidget(),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    ));
  }

  void loadDataFromAPI() {
    if (_isPresenterCalled) return;
    _tripPresenter = new TripPresenter(this);
    _tripPresenter.loadTripData();
    _isPresenterCalled = true;
  }

// Widgets
  drawTopIconsWidget() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            SizedBox(width: 20),
            drawIcon(Alignment.topLeft, Icons.star_border, _onStarIconTap),
            SizedBox(width: 20),
            drawIcon(Alignment.topRight, Icons.share, _onShareIconTap),
            Spacer(),
            drawIcon(
                Alignment.topRight, Icons.arrow_forward_ios, _onArrowIconTap),
            SizedBox(width: 20)
          ],
        ));
  }

  drawIcon(alignment, icon, _onIconTap) {
    return Align(
        alignment: alignment,
        child: GestureDetector(
          onTap: _onIconTap,
          child: Icon(
            icon == Icons.star_border ? _isFavorite ? Icons.star : icon : icon,
            color: Colors.white,
            size: 30,
          ),
        ));
  }

  drawImageWidget() {
    if (_tripData.img != null) {
      return Align(
        alignment: Alignment.center,
        child: Image.network(
          _tripData.img[_imgIndex],
          fit: BoxFit.fill,
          height: 350,
          width: MediaQuery.of(context).size.width,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  drawCircleImageIndicator() {
    if (_tripData.img != null) {
      return Container(
        margin: EdgeInsets.only(top: 320, left: 15),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: CirclePageIndicator(
            itemCount: _tripData.img.length,
            currentPageNotifier: _currentImgNotifier,
            dotColor: Colors.white.withOpacity(0.6),
            selectedDotColor: Colors.white,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  getInterestTextWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        _tripData.interest != null ? _tripData.interest : '',
        textDirection: TextDirection.rtl,
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black.withOpacity(0.7)),
      ),
    );
  }

  getDateWidget() {
    if (_tripData != null) {
      // to avoid null pointer exception
      String weekday = mapDayNumToName(DateTime.parse(_tripData.date).weekday);
      int day = DateTime.parse(_tripData.date).day;
      String month = mapMonthNumToName(DateTime.parse(_tripData.date).month);
      String time = determineTime(DateTime.parse(_tripData.date).hour,
          DateTime.parse(_tripData.date).minute);

      return Container(
          margin: EdgeInsets.all(10),
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Icon(Icons.calendar_today),
              SizedBox(
                width: 10,
              ),
              Text(
                weekday + ', $day $month , $time',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 17,
//            fontWeight: FontWeight.w900,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ));
    } else {
      return Container();
    }
  }

  getAddressWidget() {
    return Container(
        margin: EdgeInsets.all(10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 10,
            ),
            Text(
              _tripData.address != null ? _tripData.address : '',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 17,
//            fontWeight: FontWeight.w900,
                  color: Colors.black.withOpacity(0.7)),
            ),
          ],
        ));
  }

  drawTrainerInfoWidget() {
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        drawTrainerImg(),
        Text(_tripData.trainerInfo != null ? _tripData.trainerInfo + '  ' : ''),
      ],
    );
  }

  drawTrainerImg() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 100,
        width: 100,
        child: (_tripData.trainerImg != null)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.network(
                  _tripData.trainerImg.replaceAll('https', 'http'),
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ))
            : Container(),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  drawOccasionDetailWidget() {
    if (_tripData.occasionDetail != null) {
      return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Text(
                  _tripData.occasionDetail,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ));
    } else {
      return Container();
    }
  }

  drawButtonWidget() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.76,
        height: MediaQuery.of(context).size.height * 0.07,
        child: RaisedButton(
          child: Text('قم بالحجز الآن',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          textColor: Colors.white,
          onPressed: () {
            _alert = new SingleActionAlert(
                message: 'لقد تم الحجز بنجاح',
                buttonTitle: 'حسنا',
                context: context);

            _alert.showAlert();
          },
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Colors.purple,
        ));
  }

// On Tap
  _onStarIconTap() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  _onShareIconTap() {}
  _onArrowIconTap() {
    if (_imgIndex < 3) {
      setState(() {
        _imgIndex++;
        _currentImgNotifier.value = _imgIndex;
      });
    } else {
      setState(() {
        _imgIndex = 0;
        _currentImgNotifier.value = _imgIndex;
      });
    }
  }

// On Data Loaded From API
  @override
  updateView(TripModel data) {
    setState(() {
      _tripData = data;
    });
  }
}
