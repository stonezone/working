import sys
import re
import logging
from datetime import datetime

# Setup logging
logging.basicConfig(level=logging.DEBUG, format="%(levelname)s: %(message)s")

def read_ips_from_file(filename):
    # Read IPs from a given file and return a set of IPs.
    ips = set()
    try:
        with open(filename, 'r') as f:
            for line in f:
                ip = line.strip().split('/')[0]  # Ignore subnet
                ips.add(ip)
        return ips
    except FileNotFoundError:
        logging.error(f"{filename} not found.")
        return None

def remove_ip_from_text(text, ips):
    # Remove lines containing specific IPs and return the modified text.
    lines = text.split('\\n')
    new_lines = []
    removed_lines = []
    for line in lines:
        remove_line = False
        for ip in ips:
            if re.search(rf'ipv4Value="{re.escape(ip)}"', line):
                logging.debug(f"Removing line: {line}")
                remove_line = True
                removed_lines.append(line)
                break
        if not remove_line:
            new_lines.append(line)
    return '\\n'.join(new_lines), removed_lines

def main():
    # Main function.
    # Read IPs from the file
    ips = read_ips_from_file("ips.txt")
    if ips is None:
        logging.error("Aborting due to missing IP list.")
        return
    
    # Validate command-line argument
    if len(sys.argv) == 2:
        input_file = sys.argv[1]
    else:
        logging.error("Usage: python remove_ip.py <file to read>")
        return

    # Read input file
    try:
        with open(input_file, 'r') as f:
            text = f.read()
    except FileNotFoundError:
        logging.error(f"{input_file} not found.")
        return

    # Remove IPs and get removed lines
    new_text, removed_lines = remove_ip_from_text(text, ips)

    # Write to output file with date prefix
    date_prefix = datetime.now().strftime("%Y%m%d_%H%M%S_")
    output_file = f"{date_prefix}{input_file}"
    with open(output_file, "w") as f:
        f.write(new_text)

    logging.info(f"Changes saved to: {output_file}")

    # Generate summary
    print("Summary of removed lines:")
    for line in removed_lines:
        print(line)
    print(f"Total number of removed lines: {len(removed_lines)}")

if __name__ == "__main__":
    main()

