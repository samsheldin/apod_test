import 'package:apod/src/presentation/cubit/homecubit_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<HomeCubit, HomeCubitState>(
          listener: (context, state) {
            if (state.isError) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          builder: (context, state) {
            if (state.isLoading) return CircularProgressIndicator();
            if (state.isError)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context)..getData();
                      },
                      child: Text('Retry')),
                  Text(state.error)
                ],
              );
            if (state.isLoaded)
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: state.apod.hdurl ?? '',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    /* progressIndicatorBuilder: (context, url, progress) =>
                        SizedBox(
                      child: CircularProgressIndicator(),
                      height: 20,
                      width: 20,
                    ), */
                  ),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 30),
                    child: Column(
                      children: [
                        Text(
                          state.apod.title,
                          style: TextStyle(color: Colors.red),
                        ).paddingOnly(bottom: 20),
                        Text(
                          state.apod.explanation,
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          'For date :' + state.apod.date,
                          style: TextStyle(color: Colors.red),
                        ).paddingOnly(top: 20, bottom: 10),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                            if (selectedDate != null)
                              BlocProvider.of<HomeCubit>(context)
                                ..getData(
                                    date: DateFormat("yyyy-MM-dd")
                                        .format(selectedDate));
                          },
                          child: Text('Find astro for a different date'),
                        ),
                      ],
                    ),
                  )),
                ],
              );
            return Container();
          },
        ),
      ),
    );
  }
}
