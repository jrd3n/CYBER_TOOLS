#!/bin/bash

# Find all wireless interfaces by checking for the presence of "phy" in the info, which is typical for wireless interfaces.
interfaces=$(iw dev | grep Interface | awk '{print $2}')

# Check if any interfaces were found
if [ -z "$interfaces" ]; then
    echo "No wireless interfaces found."
    exit 1
fi

# Display the interfaces and ask the user to choose one
echo "Please choose a wireless interface from the list below:"
select interface in $interfaces; do
    if [ -n "$interface" ]; then
        echo "You selected $interface."
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Put the selected interface into monitor mode
echo "Putting $interface into monitor mode..."
sudo ip link set "$interface" down
sudo iw "$interface" set monitor none
sudo ip link set "$interface" up

echo "$interface is now in monitor mode."

# Ask the user how they would like to monitor
echo "How would you like to monitor? (1) Wireshark (2) Bettercap"
read -p "Select an option: " tool_choice

case $tool_choice in
    1) 
        echo "Opening Wireshark with $interface..."
        sudo wireshark -i $interface -k &
        ;;
    2)
        echo "Opening Bettercap with $interface..."
        # Note: Adjust the bettercap command according to your needs.
        # The following is a basic example to start bettercap and set the interface.


        sudo killall bettercap

        # Start Bettercap with the specified interface and the web UI caplet
        sudo ~/bettercap/bettercap -iface $interface -caplet http-ui &

        # Wait a little bit to ensure the Bettercap web UI is up
        sleep 1

        # Open Firefox to the Bettercap web UI page, without holding up the script and without console output
        firefox http://localhost:80 &>/dev/null &
        ;;
    *)
        echo "Invalid selection. Exiting."
        exit 1
        ;;
esac

echo "Monitoring setup complete."