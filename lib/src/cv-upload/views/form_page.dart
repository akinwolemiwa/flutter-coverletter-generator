import 'dart:developer';

import 'package:coverletter/src/cv-upload/models/files_model.dart';
import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:coverletter/src/widgets/custom_form.dart';
import 'package:coverletter/src/pdf-download-preview/views/pdf.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class FormPage extends ConsumerStatefulWidget {
  const FormPage({super.key});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  final outlineBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
  );
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController whatRoleController = TextEditingController();
  TextEditingController yearsOfexperienceController = TextEditingController();
  TextEditingController dateOfapplicationController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientsDepartmentController =
      TextEditingController();
  TextEditingController recipientEmailController = TextEditingController();
  TextEditingController recipientPhoneNoController = TextEditingController();

  final grayColor = AppColors.greys.shade400;
  final titleTextStyle =
      const TextStyle(color: Color(0xFF6D6D6D), fontSize: 14);

  final _fromKey = GlobalKey<FormState>();
  final hGap = const YGap(value: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tell us a little about the job",
                    style: textTheme.headlineMedium!.copyWith(
                      color: AppColors.header,
                    ),
                  ),
                  const YGap(value: 15),
                  Text(
                    "This information would help us customize your cover letter and tailor it to your special skilset and the role you are applying for",
                    style: TextStyle(
                      fontSize: 12,
                      color: grayColor,
                      fontWeight: FontWeight.normal,
                      // height: 32,
                    ),
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Company's name",
                    inputType: TextInputType.text,
                    controller: companyNameController,
                    customeError: "Please fill in the company name",
                  ),
                  const YGap(value: 15),
                  CustomForm(
                    formTitle: "Company's address",
                    inputType: TextInputType.text,
                    controller: companyAddressController,
                    customeError: "Please fill in the company address",
                  ),
                  hGap,
                  Row(
                    children: [
                      Expanded(
                        child: CustomForm(
                          formTitle: "City",
                          inputType: TextInputType.text,
                          controller: cityController,
                          customeError: "Please fill in the city address",
                        ),
                      ),
                      const XGap(value: 15),
                      Expanded(
                        child: CustomForm(
                          formTitle: "Country",
                          inputType: TextInputType.text,
                          controller: countryController,
                          customeError: "Please fill in the country details",
                        ),
                      ),
                    ],
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "What role are you applying for ?",
                    inputType: TextInputType.text,
                    controller: whatRoleController,
                    customeError: "Please fill some data",
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Years of experience",
                    inputType: TextInputType.number,
                    controller: yearsOfexperienceController,
                    customeError: "Please fill some data",
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Date of application",
                    inputType: TextInputType.datetime,
                    controller: dateOfapplicationController,
                    hint: "MM/DD/YY",
                    customeError: "Please fill some data",
                    isReadOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('MM-dd-yyyy').format(pickedDate);
                        setState(() {
                          dateOfapplicationController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Recipient's name",
                    inputType: TextInputType.text,
                    controller: recipientNameController,
                    customeError: "Please fill some data",
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Recipient's department",
                    inputType: TextInputType.text,
                    controller: recipientsDepartmentController,
                    customeError: "Please fill some data",
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Recipient's email",
                    inputType: TextInputType.text,
                    controller: recipientEmailController,
                    isFieldRequired: false,
                    customeError: "Please fill some data",
                  ),
                  hGap,
                  CustomForm(
                    formTitle: "Recipient's phone number",
                    inputType: TextInputType.number,
                    isFieldRequired: false,
                    controller: recipientPhoneNoController,
                    customeError: "Please fill some data",
                  ),
                  const YGap(value: 45),
                  PrimaryButton(
                      text: "Generate cover letter",
                      onTap: () async {
                        if (_fromKey.currentState!.validate()) {
                          final pdfFile = ref.read(fileProvider);

                          log(pdfFile!.absolute.path);

                          var pdfName = pdfFile.path.split('/').last;

                          var cvInfo = UploadCVInfo(
                            companyName: companyAddressController.text,
                            companyAddress: companyAddressController.text,
                            city: cityController.text,
                            country: countryController.text,
                            role: whatRoleController.text,
                            yearsOfExp: yearsOfexperienceController.text,
                            date: dateOfapplicationController.text,
                            recipientName: recipientNameController.text,
                            recipientDepartment:
                                recipientsDepartmentController.text,
                            recipientEmail: recipientEmailController.text,
                            recipientPhoneNo: recipientPhoneNoController.text,
                            fileName: pdfName,
                            filePath: pdfFile.absolute.path,
                          );

                          ref
                              .read(userInfoData.notifier)
                              .update((state) => cvInfo);

                          await ref.read(uploadCVProvider(
                            await cvInfo.toJson(),
                          ).future);

                          if (mounted) {
                            Navigator.of(context).pop();

                            pushNewScreen(
                              context,
                              screen: const PdfHome(),
                            );
                          }
                        }
                      }),
                  hGap,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
