# Granite Code Prompt Cookbook - WCA Chat

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent


## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @filename
```

- sample output

```markdown
This code is a sample program written in COBOL that reads data from an input file, processes the data, and writes the results to an output file. The program uses a file control section to define the input and output files, and a data division to define the data structures used in the program. The procedure division contains the main program logic, which reads records from the input file, processes them based on the record type, and writes the results to the output file. The program also includes variables to keep track of total sales, line item count, and line item total.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```text
This code is a sample program that processes a file containing customer orders and calculates the total sales. The program reads the input file line by line, identifies the record type, and performs the appropriate action based on the record type. If the record type is 'C', it increments the line item count and adds the total amount to the line item total. If the record type is 'R', it writes the line item count and line item total to the output file and resets the line item count and line item total. Finally, it calculates the total sales and displays it.

The code uses the Large Language Model from IBM Granite, which is based on the transformer decoder architecture. It also uses the IBM watsonx Code Assistant, an AI coding assistant from IBM with deep knowledge and expertise in programming languages.
```

### 3. Code Translate

- chat in WCA

```text
/translate to python @filename
```

- sample output

```python
# Assisted by watsonx Code Assistant 
#blob
def main():
    input_file = open("input.txt", "r")
    output_file = open("output.txt", "w")
    total_sales = 0
    current_record = 1
    line_item_count = 0
    line_item_total = 0
    end_of_file_flag = False
    while not end_of_file_flag:
        record_type = input_file.readline().strip()
        if record_type == "C":
            line_item_count += 1
            line_item_total += float(input_file.readline().strip())
        elif record_type == "R":
            output_file.write(str(line_item_count) + "\n")
            output_file.write(str(line_item_total) + "\n")
            line_item_count = 0
            line_item_total = 0
        total_sales += float(input_file.readline().strip())
        if record_type == "R":
            end_of_file_flag = True
    input_file.close()
    output_file.close()
    print("Total sales:", total_sales)
    print("Line item count:", line_item_count)
    print("Line item total:", line_item_total)

if __name__ == "__main__":
    main()
```


### 4. Test Case Generation

- chat in WCA

```text
/unit-test @filename
```

- sample output

```cobol
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//blob
IDENTIFICATION DIVISION.
      PROGRAM-ID. SampleProgramTests.
      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
      DATA DIVISION.
      WORKING-STORAGE SECTION.
      01  InputFile PIC X(10) VALUE "input.txt".
      01  OutputFile PIC X(10) VALUE "output.txt".
      01  ExpectedTotalSales PIC 9(10)V99 VALUE 1000000.
      01  ExpectedLineItemCount PIC 9(10)V99 VALUE 2.
      01  ExpectedLineItemTotal PIC 9(10)V99 VALUE 500000.
      PROCEDURE DIVISION.
      Main.
          PERFORM TestProcessRecord
          PERFORM TestEndOfFile
      EndOfFile.
          STOP RUN
      TestProcessRecord.
          PERFORM TestProcessRecord_C
          PERFORM TestProcessRecord_R
      TestProcessRecord_C.
          MOVE 'C' TO LineItemType
          MOVE 500000 TO TotalAmount
          PERFORM ProcessRecord
          DISPLAY "Total sales: " TotalSales
          DISPLAY "Line item count: " LineItemCount
          DISPLAY "Line item total: " LineItemTotal
          IF TotalSales <> ExpectedTotalSales OR LineItemCount <> ExpectedLineItemCount OR LineItemTotal <> ExpectedLineItemTotal THEN
              DISPLAY "TestProcessRecord_C failed."
          ELSE
              DISPLAY "TestProcessRecord_C passed."
          END IF
      TestProcessRecord_R.
          MOVE 'R' TO LineItemType
          MOVE 500000 TO TotalAmount
          PERFORM ProcessRecord
          DISPLAY "Total sales: " TotalSales
          DISPLAY "Line item count: " LineItemCount
          DISPLAY "Line item total: " LineItemTotal
          IF TotalSales <> ExpectedTotalSales OR LineItemCount <> ExpectedLineItemCount OR LineItemTotal <> ExpectedLineItemTotal THEN
              DISPLAY "TestProcessRecord_R failed."
          ELSE
              DISPLAY "TestProcessRecord_R passed."
          END IF
      TestEndOfFile.
          MOVE 'R' TO LineItemType
          MOVE 500000 TO TotalAmount
          PERFORM ProcessRecord
          DISPLAY "Total sales: " TotalSales
          DISPLAY "Line item count: " LineItemCount
          DISPLAY "Line item total: " LineItemTotal
          IF TotalSales <> ExpectedTotalSales OR LineItemCount <> ExpectedLineItemCount OR LineItemTotal <> ExpectedLineItemTotal THEN
              DISPLAY "TestEndOfFile failed."
          ELSE
              DISPLAY "TestEndOfFile passed."
          END IF
```

### 5. Review Code

- chat input in WCA

```text
review @filename
```

- sample output

```text

```

### 6. Fix Code

- chat in WCA

```text
fix @filename
```

- sample output


```cobol
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//blob
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
      9(10) VALUE 1.
      01  LineItemCount PIC 9(10) VALUE 0.
      01  LineItemTotal PIC 9(7)V99 VALUE ZERO.
      PROCEDURE DIVISION.
      Main.
          OPEN INPUT InputFile
          OPEN OUTPUT OutputFile
          PERFORM UNTIL End-OF-FILE ON InputFile
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
```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the cobol code provided. @filename
```

- sample output

```mermaid
```



### 8. Interface Generation

- chat in WCA

```text
generate cobol interface version base on the cobol code provided. @filename
```

```cobol
```

### 9. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for the cobol code provided. @filename
```

- sample output

```bash
```

## sample cobol

[good example](cobol/sample.cbl)

[bad example](cobol/bad.cbl)