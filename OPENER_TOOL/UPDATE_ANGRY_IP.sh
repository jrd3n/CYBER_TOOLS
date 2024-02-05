#!/bin/bash

# Define the folder path
folder_path=~/CYBER_TOOLS/SCRIPTS

# Initialize result string
result_string=""

# Iterate through the files in the folder
for script_file in "$folder_path"/*.sh; do
    echo $script_file
    if [ -f "$script_file" ]; then
        # Get the relative path of the script file
        relative_path=${script_file#$home_dir}

        # Extract values after colons and replace placeholders
        execution_string=$(grep "Execution_string" "$script_file" | cut -d':' -f2- | sed "s|THIS_FILE|$relative_path|g" | sed 's/^ *//')
        run_in_terminal=$(grep "Run_in_Terminal" "$script_file" | cut -d':' -f2- | sed 's/^ *//' | awk '{print ($1 == "TRUE" ? 1 : 0)}')
        directory=$(grep "Directory" "$script_file" | cut -d':' -f2- | sed 's/^ *//')
        name=$(grep "Name" "$script_file" | cut -d':' -f2- | sed 's/^ *//')

        opener_string="${name}###${execution_string}@@@${run_in_terminal}@@@${directory}###"

        result_string="${result_string}${opener_string}"

        # Print the extracted values
        echo "Script File: $script_file"
        echo "Execution_string: $execution_string"
        echo "Run_in_Terminal: $run_in_terminal"
        echo "Directory: $directory"
        echo "OPENER: $opener_string"
        echo "--------------------------------------"
    fi
done

file_path=OPENER_TOOL/prefs.xml

cp ~/.java/.userPrefs/ipscan/prefs.xml $file_path

# Update the angry ip openers section with the new openers
file_path=OPENER_TOOL/prefs.xml

# Use sed to update the 'openers' entry value in the XML file

# Use xmlstarlet to update the 'openers' entry value in the XML file
xmlstarlet ed -L -u "//entry[@key='openers']/@value" -v "${result_string}" "${file_path}"

cp $file_path ~/.java/.userPrefs/ipscan/prefs.xml