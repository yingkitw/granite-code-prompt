 # Assisted by watsonx Code Assistant 
 
import csv

def main():
    input_file = 'sales_data.csv'
    output_file = 'sales_summary.csv'

    sales_data = read_csv(input_file)
    sales_summary = summarize_sales(sales_data)
    write_csv(output_file, sales_summary)

    print(f'Sales summary written to {output_file}')

def read_csv(file):
    with open(file, 'r') as fh:
        csv_reader = csv.DictReader(fh)
        return list(csv_reader)

def summarize_sales(sales_data):
    summary = {}
    for row in sales_data:
        product = row['Product']
        amount = row['Amount']
        summary[product] = summary.get(product, 0) + int(amount)
    summary_rows = []
    for product, total_amount in summary.items():
        summary_rows.append({'Product': product, 'Total Amount': total_amount})
    return summary_rows

def write_csv(file, data):
    with open(file, 'w', newline='') as fh:
        csv_writer = csv.DictWriter(fh, fieldnames=data[0].keys())
        csv_writer.writeheader()
        for row in data:
            csv_writer.writerow(row)

if __name__ == '__main__':
    main()
