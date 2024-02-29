#!/bin/bash

# Define arrays for source keys and package names
src_keys=("lm99he9l8ns87ch" "82xgh4ycwwp06jw")
package_names=("vscode-dotnet-sdk" "Visual Studio.app")

# Directory where packages will be downloaded
dir=~/goinfre

# Function to download a package
download_package() {
    local src_key=$1
    local package_name=$2

    # Check if the package is already present in the directory
    if [ $(ls $dir | grep -x "$package_name" | wc -l ) -eq 0 ]; then
        echo "[$package_name] Not Found ❌, Get? (y/n) [None = no]"
        read -r answer
        if [ "$answer" = "y" ]; then
            # Check if the "main" binary exists
            if [ ! -e ~/mgetter ]; then
                git clone git@github.com:mait-elk42/mscrapper_c.git ~/mscrapper_c
				make -C ~/mscrapper_c all clean
				cp ~/mscrapper_c/mgetter ~
            fi

            # Get download link using "main" binary
            link=$(~/main $src_key)

            # Create directory for the package if it doesn't exist
            mkdir -p "$dir/$package_name"

            # Download the package if not already present
            if [ $(ls ~/goinfre | grep "$package_name.tar" | wc -l ) -eq 0 ]; then
				echo "Downloading $dir/$package_name ⬇️"
                curl --create-dirs --progress-bar "$link" -o "$dir/$package_name.tar"
            fi
	
            # Remove existing directory and extract the downloaded package
            rm -rdf "$dir/$package_name"
			echo "Extracting $package_name 🔄"
            cd "$dir/" && tar -xf "$package_name.tar"
	        echo "[$package_name] Ready To Use ✅"
        else
            echo "Got It."
        fi
    else
        echo "[$package_name] ✅"
    fi
}

# Loop through source keys and package names to download each package
for ((i=0; i<${#src_keys[@]}; i++)); do
    download_package "${src_keys[i]}" "${package_names[i]}"
done
