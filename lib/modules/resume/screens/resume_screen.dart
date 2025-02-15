import 'package:ai_interview/modules/resume/widget/resume_list_tile.dart';
import 'package:ai_interview/modules/shared/api/api_calls.dart';
import 'package:ai_interview/modules/shared/widgets/colors.dart';
import 'package:ai_interview/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:ai_interview/riverpod/resumes_rvpd.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ResumeScreen extends ConsumerStatefulWidget {
  const ResumeScreen({super.key});

  @override
  ConsumerState<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends ConsumerState<ResumeScreen> {
  bool _pickingFile = false;
  bool _isLoading = true;

  Future<String> pickFile() async {
    setState(() {
      _pickingFile = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );
    if (result != null) {
      return result.files.first.path!;
    }
    setState(() {
      _pickingFile = false;
    });
    return '';
  }

  Future<void> getResume() async {
    ref.read(resumesProvider.notifier).setResumes(await ApiCalls().getResume());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.watch(resumesProvider).isEmpty) {
        getResume();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: AppColors.blackbg,
          shape: const CircleBorder(),
          onPressed: () async {
            await pickFile().then((path) async {
              await ApiCalls().uploadResume(context, path).then((_) {
                getResume();

                setState(() {
                  _pickingFile = false;
                });
              });
            });
          },
          child: _pickingFile
              ? const CustomProgressIndicator(color: AppColors.white)
              : SvgPicture.asset("assets/icons/file_add.svg"),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Resume Review',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CustomProgressIndicator(),
            )
          : RefreshIndicator(
              backgroundColor: AppColors.blackbg,
              color: AppColors.white,
              onRefresh: () async {
                await getResume();
              },
              child: ref.watch(resumesProvider).isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: ref.watch(resumesProvider).length,
                      itemBuilder: (context, index) {
                        return ResumeListTile(
                            resume: ref.watch(resumesProvider)[index]);
                      },
                    )
                  : Center(
                      child: Text(
                        "No resumes found",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
    );
  }
}
