import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_state.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_state.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_state.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';

import 'package:diantar_jarak/data/models/detail_perjalanan_model/detail_perjalanan_model.dart';
import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_pengantaran_model.dart';
import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_perjalanan_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPengantaranPage extends StatelessWidget {
  final String perjalananID;

  const DetailPengantaranPage({super.key, required this.perjalananID});

  Widget buildRow(String label, String? value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          Text(
            ":",
            style: TextStyle(
              fontSize: 18,
              color: CustomColorPalette.textColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    value ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: CustomColorPalette.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialogPerjalanan(
      BuildContext context, DetailPerjalananModel detail) {
    final TextEditingController shiftKeController =
        TextEditingController(text: detail.shiftKe.toString());
    final TextEditingController jamPengirimanController =
        TextEditingController(text: detail.jamPengiriman ?? '');
    final TextEditingController jamKembaliController =
        TextEditingController(text: detail.jamKembali ?? '');
    final TextEditingController updateByController =
        TextEditingController(text: detail.updateBy);

    // Daftar opsi status
    final List<String> statusOptions = [
      'Belum Dikirim',
      'Sudah Dikirim',
      'Selesai',
      'Tidak Dikirim',
      'Salah Input',
    ];

    String? selectedStatus = detail.status;

    // Variabel untuk menandai error pada setiap field
    bool isShiftKeEmpty = false;
    bool isJamPengirimanEmpty = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Update Detail Perjalanan'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: shiftKeController,
                          decoration: const InputDecoration(
                            labelText: 'Shift Ke',
                            labelStyle: TextStyle(fontSize: 14),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            isDense: true,
                          ),
                        ),
                        if (isShiftKeEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              "Harus Diisi",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateTimePicker(
                            context, jamPengirimanController, 'Jam Pengiriman'),
                        if (isJamPengirimanEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              "Harus Diisi",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildDateTimePicker(
                        context, jamKembaliController, 'Jam Kembali'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: updateByController,
                      decoration: const InputDecoration(
                        labelText: 'Update By',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        isDense: true,
                      ),
                      items: statusOptions.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedStatus = value!;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    // Validasi input yang wajib
                    setState(() {
                      isShiftKeEmpty = shiftKeController.text.isEmpty;
                      isJamPengirimanEmpty =
                          jamPengirimanController.text.isEmpty;
                    });

                    if (isShiftKeEmpty || isJamPengirimanEmpty) {
                      print('Pastikan semua field yang wajib sudah terisi');
                      return;
                    }

                    try {
                      final updatedDetail = UpdateDetailPerjalananModel(
                        perjalananID: detail.perjalananID,
                        shiftKe: int.parse(shiftKeController.text),
                        jamPengiriman:
                            _getBackendDateFormat(jamPengirimanController.text),
                        jamKembali: jamKembaliController.text.isEmpty
                            ? ''
                            : _getBackendDateFormat(jamKembaliController.text),
                        updateBy: updateByController.text,
                        status: selectedStatus ?? '', // Pastikan status dikirim
                      );

                      // Kirim event untuk update
                      context.read<UpdateDetailPerjalananBloc>().add(
                            SubmitUpdateDetailPerjalanan(updatedDetail),
                          );

                      Navigator.of(context).pop(); // Tutup dialog

                      // Emit event untuk memperbarui data di halaman utama
                      context.read<DetailPerjalananBloc>().add(
                            FetchDetailPerjalanan(perjalananID),
                          );

                      // Tampilkan dialog sukses
                      _showSuccessDialogPerjalanan(context);
                    } catch (e) {
                      print('Error updating: $e');
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

// Fungsi untuk menampilkan dialog sukses
  void _showSuccessDialogPerjalanan(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Update Berhasil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Sudah Terupdate Perjalanannya!'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context, TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
        labelStyle: const TextStyle(fontSize: 14),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        isDense: true,
      ),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (selectedTime != null) {
            final DateTime dateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            // Gunakan fungsi FormatDate untuk mendapatkan format tanggal yang diinginkan
            controller.text = formatDate(dateTime);

            // Cetak format backend untuk debugging
            final String backendDate = _getBackendDateFormat(controller.text);
            print('Backend Date: $backendDate'); // Debugging
          }
        }
      },
    );
  }

// Fungsi untuk mendapatkan format tanggal backend
  String _getBackendDateFormat(String dateString) {
    // Parsing tanggal dari UI string
    DateFormat uiFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    DateTime dateTime = uiFormat.parse(dateString.replaceAll(' WIB', ''));

    // Format untuk backend dengan milidetik
    DateFormat backendFormat = DateFormat('yyyy-MM-dd HH:mm:ss.000');
    return backendFormat.format(dateTime);
  }

// Fungsi untuk memformat tanggal ke format "Jumat, 30 Agustus 2024 15:11 WIB"
  String formatDate(DateTime dateTime) {
    DateFormat uiFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    return '${uiFormat.format(dateTime)} WIB';
  }

  void showUpdateDialogPengantaran(
      BuildContext context, DetailPerjalananModel detail) {
    final TextEditingController nomorFakturController =
        TextEditingController(text: detail.nomorFaktur.toString());
    final TextEditingController updateByController =
        TextEditingController(text: detail.updateBy);

    bool showError = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Update Detail Pengantaran'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nomorFakturController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Faktur',
                        labelStyle: const TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                            color: CustomColorPalette.hintTextColor,
                            fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: CustomColorPalette.surfaceColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        isDense: true,
                      ),
                    ),
                    if (showError)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nomor Faktur wajib di update!',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: updateByController,
                      decoration: InputDecoration(
                        labelText: 'Update By',
                        labelStyle: const TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                            color: CustomColorPalette.hintTextColor,
                            fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: CustomColorPalette.surfaceColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    // Cek jika nomor faktur masih "0"
                    if (nomorFakturController.text.trim() == '0') {
                      setState(() {
                        showError = true;
                      });
                      return;
                    }

                    final updateDetail = UpdateDetailPengantaranModel(
                      pengantaranID: detail.pengantaranID.toString(),
                      perjalananID: detail.perjalananID,
                      nomorFaktur: nomorFakturController.text,
                      updateBy: updateByController.text,
                    );

                    context.read<UpdateDetailPengantaranBloc>().add(
                          SubmitUpdateDetailPengantaran(updateDetail),
                        );

                    Navigator.of(context).pop();

                    // Tampilkan dialog sukses
                    _showSuccessDialogPengantaran(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSuccessDialogPengantaran(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Update Berhasil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Sudah Terupdate Pengantarannya!'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<DetailPerjalananBloc>()
        .add(FetchDetailPerjalanan(perjalananID));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Perjalanan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColorPalette.textColor,
          ),
        ),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DetailPerjalananBloc, DetailPerjalananState>(
            listener: (context, state) {
              if (state is DetailPerjalananError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')));
              }
            },
          ),
          BlocListener<UpdateDetailPengantaranBloc,
              UpdateDetailPengantaranState>(
            listener: (context, state) {
              if (state is UpdateDetailPengantaranSuccess) {
                // Ambil state terbaru dari HistoryPengantaranBloc
                final historyState =
                    context.read<HistoryPengantaranBloc>().state;

                // Tentukan halaman dan page size dinamis dari state
                int currentPage = 1;
                int pageSize = 10;

                if (historyState is HistoryLoaded) {
                  currentPage = historyState.currentPage;
                  pageSize =
                      historyState.histories.length; // Ambil page size aktif
                }

                // Muat ulang data Detail Perjalanan dan History
                context
                    .read<DetailPerjalananBloc>()
                    .add(FetchDetailPerjalanan(perjalananID));
                context
                    .read<HistoryPengantaranBloc>()
                    .add(FetchHistoryPengantaran(
                      page: currentPage,
                      pageSize: pageSize, // Gunakan page size yang dinamis
                      filters: historyState.currentFilters,
                    ));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Detail Pengantaran berhasil diperbarui!')),
                );
              } else if (state is UpdateDetailPengantaranError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
          ),
          BlocListener<UpdateDetailPerjalananBloc, UpdateDetailPerjalananState>(
            listener: (context, state) {
              if (state is UpdateDetailPerjalananSuccess) {
                // Memperbarui Detail Perjalanan
                context.read<DetailPerjalananBloc>().add(
                      FetchDetailPerjalanan(perjalananID),
                    );

                // Memastikan HistoryState telah di-load dengan aman
                final historyState =
                    context.read<HistoryPengantaranBloc>().state;
                int currentPage = 1;
                int pageSize = 10;

                if (historyState is HistoryLoaded) {
                  currentPage = historyState.currentPage;
                  pageSize = historyState.histories.length;
                }

                // Emit event untuk memperbarui history
                context.read<HistoryPengantaranBloc>().add(
                      FetchHistoryPengantaran(
                        page: currentPage,
                        pageSize: pageSize,
                        filters: (historyState is HistoryLoaded)
                            ? historyState.currentFilters
                            : {},
                      ),
                    );

                // Menampilkan notifikasi sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Perjalanan dan History berhasil diperbarui!'),
                  ),
                );
              } else if (state is UpdateDetailPerjalananError) {
                // Menampilkan notifikasi error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gagal memperbarui: ${state.message}'),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<DetailPerjalananBloc, DetailPerjalananState>(
          builder: (context, state) {
            if (state is DetailPerjalananLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailPerjalananLoaded) {
              state.detailPerjalanan.sort(
                  (a, b) => a.urutanPengiriman.compareTo(b.urutanPengiriman));

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 300, right: 300, bottom: 10),
                      decoration: BoxDecoration(
                        color: CustomColorPalette.BgBorder,
                        border: Border.all(color: CustomColorPalette.textColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Detail Pengiriman',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF363535),
                                ),
                              ),
                              SizedBox(width: Sizes.dp1(context)),
                              ElevatedButton(
                                onPressed: () {
                                  _showUpdateDialogPerjalanan(
                                      context, state.detailPerjalanan[0]);
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            title: Text(
                              capitalizeWords(
                                  state.detailPerjalanan[0].namaDriver),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColorPalette.textColor,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                buildRow(
                                    'Shift',
                                    state.detailPerjalanan[0].shiftKe
                                        .toString()),
                                buildRow(
                                    'Jam Pengiriman',
                                    state.detailPerjalanan[0].jamPengiriman
                                        .toString()),
                                buildRow(
                                    'Jam Kembali',
                                    state.detailPerjalanan[0].jamKembali
                                        .toString()),
                                buildRow('Tipe Kendaraan',
                                    state.detailPerjalanan[0].tipeKendaraan),
                                buildRow(
                                    'Nomor Polisi Kendaraan',
                                    state.detailPerjalanan[0]
                                        .nomorPolisiKendaraan),
                                buildRow('Created By',
                                    state.detailPerjalanan[0].createdBy),
                                buildRow('Created Date',
                                    state.detailPerjalanan[0].createdDate),
                                buildRow(
                                    'Status', state.detailPerjalanan[0].status),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 300, right: 300, bottom: 10),
                      decoration: BoxDecoration(
                        color: CustomColorPalette.BgBorder,
                        border: Border.all(color: CustomColorPalette.textColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detail Customers',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF363535),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: state.detailPerjalanan.map((detail) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          detail.displayName,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColorPalette.textColor,
                                          ),
                                        ),
                                        SizedBox(width: Sizes.dp1(context)),
                                        ElevatedButton(
                                          onPressed: () {
                                            showUpdateDialogPengantaran(
                                                context, detail);
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildRow('Urutan Pengiriman',
                                            detail.urutanPengiriman.toString()),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  'Latitude',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: CustomColorPalette
                                                        .textColor,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: CustomColorPalette
                                                      .textColor,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Flexible(
                                                child: Text(
                                                  detail.inputLatitude
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: CustomColorPalette
                                                        .textColor,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.location_on_rounded,
                                                  size: 36,
                                                  color: Color(0xFF8A2BE2),
                                                ),
                                                onPressed: () {
                                                  if (detail.inputLatitude !=
                                                          null &&
                                                      detail.inputLongitude !=
                                                          null) {
                                                    launch(
                                                        'https://www.google.com/maps/search/?api=1&query=${detail.inputLatitude},${detail.inputLongitude}');
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        buildRow('Longitude',
                                            detail.inputLongitude.toString()),
                                        buildRow('Lokasi', detail.lokasi),
                                        buildRow('Nomor Faktur',
                                            detail.nomorFaktur.toString()),
                                        const Divider(color: Colors.purple),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 300, right: 300),
                      decoration: BoxDecoration(
                        color: CustomColorPalette.BgBorder,
                        border: Border.all(color: CustomColorPalette.textColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Google Maps',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF363535),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.map_rounded,
                                  size: 30,
                                  color: Color(0xFF8A2BE2),
                                ),
                                onPressed: () {
                                  if (state.detailPerjalanan[0].googleMapsURL !=
                                          null &&
                                      state.detailPerjalanan[0].googleMapsURL!
                                          .isNotEmpty) {
                                    launch(state
                                        .detailPerjalanan[0].googleMapsURL!);
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    buildRow('Min Distance',
                                        '${state.detailPerjalanan[0].minJarakPengiriman?.toStringAsFixed(2)} km'),
                                    buildRow('Min Duration',
                                        '${state.detailPerjalanan[0].minDurasiPengiriman?.toStringAsFixed(2)} minutes'),
                                    buildRow('Update By',
                                        '${state.detailPerjalanan[0].updateBy} (${state.detailPerjalanan[0].updateAt})'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DetailPerjalananError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
