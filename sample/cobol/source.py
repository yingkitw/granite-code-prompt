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