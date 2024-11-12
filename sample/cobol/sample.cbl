      IDENTIFICATION DIVISION.
      PROGRAM-ID. SampleProgram.

      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
      FILE-CONTROL.
          SELECT InputFile ASSIGN TO "input.txt"
              ORGANIZATION IS LINE SEQUENTIAL.
      
          SELECT OutputFile ASSIGN TO "output.txt"
              ORGANIZATION IS LINE SEQUENTIAL.
      
      DATA DIVISION.
      FILE SECTION.
      FD InputFile.
      01  RecordType PIC X(10).
      01  CustomerName PIC X(30).
      01  OrderDate PIC X(8).
      01  TotalAmount PIC 9(7)V99.
      
      WORKING-STORAGE SECTION.
      01  TotalSales PIC 9(10)V99 VALUE ZERO.
      01  CurrentRecord PIC 9(10) VALUE 1.
      01  LineItemCount PIC 9(10) VALUE 0.
      01  LineItemTotal PIC 9(7)V99 VALUE ZERO.
      
      PROCEDURE DIVISION.
      Main.
          OPEN INPUT InputFile
          OPEN OUTPUT OutputFile
      
          PERFORM UNTIL END-OF-FILE ON InputFile
              READ InputFile
                  AT END MOVE 'Y' TO EndOfFileFlag
                  NOT AT END PERFORM ProcessRecord
      
              IF EndOfFileFlag = 'Y' THEN
                  DISPLAY "Processing complete."
                  CLOSE InputFile
                  CLOSE OutputFile
                  STOP RUN
              END IF
          END-PERFORM.
      
          GO TO Main
      
      ProcessRecord.
          MOVE RecordType TO LineItemType
          IF LineItemType = 'C' THEN
              ADD 1 TO LineItemCount
              ADD TotalAmount TO LineItemTotal
          ELSE IF LineItemType = 'R' THEN
              WRITE OutputFile FROM LineItemCount
              WRITE OutputFile FROM LineItemTotal
              CLEAR LineItemCount
              CLEAR LineItemTotal
          END IF.
      
          ADD TotalAmount TO TotalSales
      
      EndOfFile.
          DISPLAY "Total sales: " TotalSales
          DISPLAY "Line item count: " LineItemCount
          DISPLAY "Line item total: " LineItemTotal
      
          CLOSE InputFile
          CLOSE OutputFile