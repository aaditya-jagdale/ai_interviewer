import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResumeListTile extends StatelessWidget {
  final FileObject resume;
  const ResumeListTile({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(),
        SlideEffect(
          begin: Offset(0, 1),
          end: Offset(0, 0),
          duration: Duration(milliseconds: 300),
        )
      ],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/file.svg"),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resume.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${DateFormat.yMMMd().format(DateTime.parse(resume.createdAt!))} · ${(resume.metadata!['size'] / 1024 / 1024).toStringAsFixed(2)} MB",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
