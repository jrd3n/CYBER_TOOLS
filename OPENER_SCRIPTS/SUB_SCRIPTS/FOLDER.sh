dir=~/Documents/BOXES/$comment
mkdir $dir -p   # The -p flag ensures the directory is created if it doesn't exist
cd $dir || exit 1  # Exit the script if cd fails