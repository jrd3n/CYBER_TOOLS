import os
import pandas as pd
from termcolor import colored

directory_path = "~/CYBER_TOOLS/OPENER_SCRIPTS"
directory_path = os.path.expanduser(directory_path)

def extract_table(file_path):

    # Read the file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Find the start and end of the table
    start_line = end_line = None
    for i, line in enumerate(lines):
        if "Angry IP information" in line:
            start_line = i + 1 # Change to i + 2 to skip the dashes line
        elif "Script information" in line:
            end_line = i - 1
            break

    # Extract the table lines and parse them into a list of lists
    table_data = [line.strip().split('|')[1:-1] for line in lines[start_line:end_line]]

    # Create a DataFrame from the parsed data
    columns = table_data.pop(0)
    dataframe = pd.DataFrame(table_data[1:], columns=columns)

    # Strip extra spaces
    dataframe = dataframe.apply(lambda x: x.str.strip())

    return dataframe # Return the DataFrame

def main():
    all_tables = [] # Create a list to hold all tables

    for filename in sorted(os.listdir(directory_path)):
        if filename.endswith(".sh"):
            file_path = os.path.join(directory_path, filename)

            print(colored(f"{filename}", 'green'),end="\t")

            table = extract_table(file_path)

            if not table.empty:

                table.columns = table.columns.str.strip()

                # Replace the home directory with ~ in the file path
                file_path_tilde = file_path.replace(os.path.expanduser("~"), "~")

                # Create the opener_string column
                table['opener_string'] = table.apply(
                    lambda row: f"{row['Angry Name']}###{row['Execution String'].replace('THIS_FILE', file_path_tilde)}@@@{'1' if row['Run in Terminal'] == 'TRUE' else '0'}@@@{row['Directory']}###",
                    axis=1)

                print(colored(f"Table Found:", 'green'))
                print(f"{table}\n")

                # this is the point i want to make the opener string and change the THIS_FILE to the actual dir of the script

                all_tables.append(table) # Append the table to the list
            else:
                print(colored(f"No table found\n", 'red'))

    combined_dataframe = pd.concat(all_tables, ignore_index=True) # Concatenate all tables into one DataFrame

    combined_dataframe = combined_dataframe.sort_values(by='Angry Name')

    print(colored("Combined Table:", 'blue'))
    print(combined_dataframe) # Print the combined DataFrame

    # Concatenate all the items in the opener_string column
    result_string = ''.join(combined_dataframe['opener_string'])

    print(colored("Concatenated Opener Strings:", 'blue'))
    print(result_string) # Print the concatenated opener strings

    # Update the angry ip openers section with the new openers

    from lxml import etree
    import shutil

    main_prefs_file = os.path.expanduser('~/.java/.userPrefs/ipscan/prefs.xml') # Expanding the ~ character

    local_prefs_file = os.path.expanduser('~/CYBER_TOOLS/OPENER_TOOL/prefs.xml') # Expanding the ~ character

    # Copy the file
    shutil.copy(main_prefs_file, local_prefs_file)

    print(f"Copied preferences file from {main_prefs_file} to {local_prefs_file}")
    
    parser = etree.XMLParser(remove_blank_text=True)
    tree = etree.parse(local_prefs_file, parser)
    root = tree.getroot()

    doctype = '<!DOCTYPE map SYSTEM "http://java.sun.com/dtd/preferences.dtd">'

    for entry in root.findall('.//entry'):
        key = entry.get('key')
        if key == 'openers':
            entry.set('value', result_string)

    with open(local_prefs_file, 'wb') as f:
        f.write(b'<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n')
        # f.write(doctype.encode('utf-8') + b'\n')
        tree.write(f)

    shutil.copy(local_prefs_file,main_prefs_file)

if __name__ == "__main__":
    main()