import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_muslim/helpers/timesApp.dart';
import 'package:smart_muslim/models/datetimes_pray.dart';
import 'package:smart_muslim/providers/api_connection.dart';

import 'package:smart_muslim/providers/location_device.dart';
import 'package:smart_muslim/state_managements/bloc/bloc/location_bloc.dart';
import 'package:smart_muslim/state_managements/bloc/praybloc/pray_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Map<String, dynamic> locationDevice = Map<String, dynamic>();
  String infoError = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is SuccessGetLocation) {
          locationDevice = state.result;

          Position pos = locationDevice['position'];
          context
              .read<PrayBloc>()
              .add(GetDefaultPrayTime(lat: pos.latitude, lon: pos.longitude));
        }

        if (state is FailedGetLocation) {
          locationDevice['cityName'] = state.info;
        }

        if (state is LoadingGetLocation) {
          locationDevice['cityName'] = 'Loading...';
        }

        return Scaffold(
          appBar: AppBar(actions: [
            ElevatedButton(
              onPressed: () async {
                // ApiConnection().getDailyTimesPray(
                //     pos.latitude.toString(), pos.longitude.toString());
                // final result = await LocationDevice().determinePosition();
                // print(result);
                // context.read<PrayBloc>().add(
                //     GetDefaultPrayTime(lat: pos.latitude, lon: pos.longitude));
              },
              child: Text('OK'),
            ),
          ]),
          body: Column(
            children: <Widget>[
              // point a
              Flexible(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/magrib.jpeg')),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white70,
                          ),
                          height: MediaQuery.of(context).size.width / 5,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Magrib'),
                              Text('18.18'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70,
                            ),
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.location_pin),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    locationDevice['cityName'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              BlocBuilder<PrayBloc, PrayState>(
                builder: (context, state) {
                  if (state is LoadingDefaultPrayTime) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is FailureDefaultPrayTime) {
                    return Container(
                      child: Center(child: Text('GAGAL LOAD DATA')),
                    );
                  }

                  if (state is SuccessDefaultPrayTime) {
                    var data = state.dataPrayTime.datetime[0].times;
                    var datas = data.toJson();
                    print(datas.length);
                    print('datas ====> $datas');
                    return Flexible(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber,
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: datas.length,
                          itemBuilder: (context, index) {
                            var items = datas.entries.toList();
                            return ListTile(
                              leading: Text(items[index].key),
                              title: Align(
                                  alignment: Alignment.center,
                                  child: Text(items[index].value)),
                              trailing: Icon(Icons.volume_up_rounded),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
