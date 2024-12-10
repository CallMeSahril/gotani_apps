import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:gotani_apps/app/modules/admin_product/form_product/controllers/form_product_controller.dart';

import '../controllers/edit_produk_controller.dart';

class EditProdukView extends GetView<EditProdukController> {
  const EditProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide.none,
    );
    return GetBuilder(
        init: FormProductController(),
        builder: (formController) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Edit Produk',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
            ),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Foto',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: formController.pickImage,
                                      child: Container(
                                        height: 54,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: formController.image == null
                                              ? Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    'Choose file',
                                                    style: TextStyle(
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        File(formController
                                                            .image!.path),
                                                        height: 32,
                                                        width: 32,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Text(
                                                      'File selected',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Nama Barang',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: formController.namaBarang,
                                      decoration: InputDecoration(
                                        hintText: 'Nama barang',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: border,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter product name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Harga',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: formController.harga,
                                      decoration: InputDecoration(
                                          prefixText: 'Rp. ',
                                          hintText: '40.000,00',
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: border),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter price';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Kategori',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    DropdownButtonFormField<int>(
                                      value:
                                          formController.selectedCategory.value,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: border,
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('Bibit'),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text('Pupuk'),
                                        ),
                                        DropdownMenuItem(
                                          value: 4,
                                          child: Text('Racun'),
                                        ),
                                        DropdownMenuItem(
                                          value: 5,
                                          child: Text('Alat Tani'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        formController.selectedCategory.value =
                                            value!;
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select a category';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Stok',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: formController.stok,
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: border,
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Stok';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Weight',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: formController.weight,
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: border,
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Weight';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Deskripsi',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: formController.deskripsi,
                                      decoration: InputDecoration(
                                        hintText: 'Deskripsi',
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: border,
                                      ),
                                      maxLines: 3,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter description';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            formController.editProduct(
                                                controller.idProduk.value);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                          ),
                                          child: const Text('Edit'),
                                        ),
                                        const SizedBox(width: 12),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                          ),
                                          child: const Text('Back'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
