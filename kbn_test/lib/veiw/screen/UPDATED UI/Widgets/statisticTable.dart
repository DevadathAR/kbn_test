import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';

class Statisticpagetable extends StatefulWidget {
  const Statisticpagetable({Key? key}) : super(key: key);

  @override
  _StatisticpagetableState createState() => _StatisticpagetableState();
}

class _StatisticpagetableState extends State<Statisticpagetable> {
  final GlobalKey _globalKey = GlobalKey();

  // Define the headers and row data
  final List<String> headers = ['Name', 'Percentage'];

  // Sample data for the table rows
  final List<List<String>> rowData = [
    ['Tile A', '25%'],
    ['Tile B', '40%'],
    ['Tile C', '15%'],
    ['Tile D', '10%'],
    ['Tile E', '50%'],['Tile A', '25%'],
    ['Tile B', '40%'],
    ['Tile C', '15%'],
    ['Tile D', '10%'],
    ['Tile E', '50%'],['Tile A', '25%'],
    ['Tile B', '40%'],
    ['Tile C', '15%'],
    ['Tile D', '10%'],
    ['Tile E', '50%'],['Tile A', '25%'],
    ['Tile B', '40%'],
    ['Tile C', '15%'],
    ['Tile D', '10%'],
    ['Tile E', '50%'],['Tile A', '25%'],
    ['Tile B', '40%'],
    ['Tile C', '15%'],
    ['Tile D', '10%'],
    ['Tile E', '50%'],
  ];

  Future<void> shareTableText() async {
    String tableText = headers.join('\t') + '\n';
    for (var row in rowData) {
      tableText += row.join('\t') + '\n';
    }
    await Share.share(tableText);
  }

  // Future<void> shareTableScreenshot() async {
  //   try {
  //     RenderRepaintBoundary boundary = _globalKey.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData? byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);

  //     if (byteData != null) {
  //       Uint8List pngBytes = byteData.buffer.asUint8List();
  //       final tempDir = await getTemporaryDirectory();
  //       final file =
  //           await File('${tempDir.path}/table_screenshot.png').create();
  //       await file.writeAsBytes(pngBytes);

  //       final XFile xFile = XFile(file.path);
  //       await Share.shareXFiles([xFile], text: 'Table Screenshot');
  //     }
  //   } catch (e) {
  //     print('Error sharing screenshot: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                colorDeclaration(title: previousMonth),
                colorDeclaration(title: currentMonth),
              ],
            ),
            const SizedBox(height: 5),
            RepaintBoundary(
              key: _globalKey,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    children: headers
                        .map((header) => _buildHeaderCell(header))
                        .toList(),
                  ),
                  ...rowData.map((row) => TableRow(
                        children:
                            row.map((cell) => _buildDataCell(cell)).toList(),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                GestureDetector(
                  onTap: shareTableText,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: tealblue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SvgPicture.asset(
                        shareIcon,
                        width: 10,
                        height: 10,
                        color: white,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.5, horizontal: 5.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.5, horizontal: 5.0),
      child: Text(
        text,
        style: AppTextStyle.normalText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
