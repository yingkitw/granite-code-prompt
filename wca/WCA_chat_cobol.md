# WCA Chat Command Cookbook - COBOL

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

- you can leverage the [sample code provided](../sample/cobol/)

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample cobol

[good example](../sample/cobol/sample.cbl)

[bad example](../sample/cobol/bad.cbl)

## use cases

### 1. Code Generation

- chat in WCA
```
generate cobol to connect to db2 and do a query, please output in markdown
```

```cobol
* Assisted by watsonx Code Assistant 
* watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
IDENTIFICATION DIVISION.
PROGRAM-ID. DB2CONNECT.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 SQLCA PIC S9(08) COMP.
01 SQLCODE PIC S9(04) COMP.
01 SQLSTATE PIC X(5).
01 DBCNAM PIC X(10) VALUE 'DB2'.
01 DBCPWD PIC X(10) VALUE 'PASSWORD'.
01 DBCTCP PIC S9(04) COMP VALUE 50000.
01 DBCHOST PIC X(20) VALUE 'HOSTNAME'.
01 DBCPORT PIC S9(04) COMP VALUE 50000.
01 DBCTABL PIC X(20) VALUE 'TABLENAME'.
01 DBCQRY  PIC X(100) VALUE 'SELECT * FROM TABLENAME'.
01 DBCQRYLEN PIC S9(04) COMP VALUE 0.
01 DBCQRYOUT PIC X(1000).
01 DBCQRYOUTLEN PIC S9(04) COMP VALUE 0.

PROCEDURE DIVISION.
MAIN-PARAGRAPH.
    PERFORM INITIALIZE-SQLCA.
    PERFORM CONNECT-TO-DB2.
    PERFORM EXECUTE-QUERY.
    PERFORM CLOSE-CONNECTION.
    STOP RUN.

INITIALIZE-SQLCA.
    MOVE 0 TO SQLCA.
    MOVE 0 TO SQLCODE.
    MOVE SPACES TO SQLSTATE.

CONNECT-TO-DB2.
    PERFORM DB2CONNECT USING
        DBCNAM
        DBCPWD
        DBCTCP
        DBCHOST
        DBCPORT
        SQLCA.
    IF SQLCODE NOT= 0
        DISPLAY 'Error connecting to DB2'
        STOP RUN.

EXECUTE-QUERY.
    MOVE LENGTH OF DBCQRY TO DBCQRYLEN.
    PERFORM DB2PREPARE USING
        DBCQRY
        DBCQRYLEN
        SQLCA.
    IF SQLCODE NOT= 0
        DISPLAY 'Error preparing query'
        STOP RUN.
    PERFORM DB2EXECUTE USING
        SQLCA.
    IF SQLCODE NOT= 0
        DISPLAY 'Error executing query'
        STOP RUN.
    PERFORM DB2FETCH USING
        DBCQRYOUT
        DBCQRYOUTLEN
        SQLCA.
    IF SQLCODE NOT= 0
        DISPLAY 'Error fetching results'
        STOP RUN.
    DISPLAY DBCQRYOUT.

CLOSE-CONNECTION.
    PERFORM DB2DISCONNECT USING
        SQLCA.
    IF SQLCODE NOT= 0
        DISPLAY 'Error disconnecting from DB2'
        STOP RUN.

STOP RUN.
```

### 2. Code Explanation

- chat in WCA

```text
/explain @sample.cbl
```

- sample output

```markdown
This is a COBOL program that processes sales records and calculates the total sales for each record type. The program reads input from a file named "input.txt" and writes output to a file named "output.txt". The input file contains records with the following fields:

RecordType: a 10-character field indicating the type of record (e.g., "C" for customer record, "R" for record separator)
CustomerName: a 30-character field containing the name of the customer
OrderDate: a 8-character field containing the date of the order
TotalAmount: a 7-digit numeric field containing the total amount of the order
The program processes each record in the input file, and for each customer record, it increments the line item count and adds the total amount to the line item total. When it encounters a record separator record, it writes the line item count and line item total to the output file and resets the counters.

After processing all the records, the program displays the total sales, line item count, and line item total, and then closes the input and output files.
```

### 3. Code Translate

- chat in WCA

```text
/translate to python @sample.cbl
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

### 4. Generate Diagram

- chat in WCA

```text
generate mermaid diagram @sample.cbl
```

- sample output

```mermaid
flowchart LR
    subgraph InputFile
        direction TB
        RecordType --> RecordType
        CustomerName --> CustomerName
        OrderDate --> OrderDate
        TotalAmount --> TotalAmount
    end
    subgraph OutputFile
        direction TB
        LineItemCount --> LineItemCount
        LineItemTotal --> LineItemTotal
    end
    subgraph Main
        direction TB
        Main --> ProcessRecord
        Main --> EndOfFile
        Main --> Main
    end
    subgraph ProcessRecord
        direction TB
        ProcessRecord --> LineItemType
        ProcessRecord --> LineItemCount
        ProcessRecord --> LineItemTotal
        ProcessRecord --> TotalAmount
    end
    subgraph EndOfFile
        direction TB
        EndOfFile --> TotalSales
        EndOfFile --> LineItemCount
        EndOfFile --> LineItemTotal
    end
```
