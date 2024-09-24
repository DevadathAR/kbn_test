import 'package:flutter/material.dart';

Widget jobTable(){
  return Table(
    border: TableBorder.all(width: 0.25), // Set the border thickness around the table to half of the original width
    children: List.generate(7, (rowIndex) {
      return TableRow(
        children: List.generate(10, (columnIndex) {
          return TableCell(
            child: SizedBox(
              height: 30.0, // Set the height of each cell
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.25), // Set the border thickness around each cell to half of the original width
                  color: Colors.white, // Add a white background color
                ),
                child: Center(
                  child: Text('Cell ${rowIndex + 1},${columnIndex + 1}'),
                ),
              ),
            ),
          );
        }),
      );
    }),
  );
}