#!/bin/bash

# file containing source keys:package names
input_file=~/files.nsx

# directory where packages will be downloaded
dir=~/goinfre

# function to download a package
download_package() {
    local src_key=$1
    local package_name=$2

    # check if the package is already present in the directory
    if [ $(ls "$dir" | grep -x "$package_name" | wc -l ) -eq 0 ] ; then
        echo "[$package_name] Not Found ❌, Get? (y/n) [None = no]"
        # check if the "mgetter" binary exists
        if [ ! -e ~/mgetter ]; then
            make -C mscrapper_c all clean
            cp mscrapper_c/mgetter ~
        fi

        # get download link using "mgetter" binary
        link=$(~/mgetter "$src_key")

        # create directory for the package if it doesn't exist
        mkdir -p "$dir/$package_name"

        # download the package if not already present
        if [ $(ls ~/goinfre | grep "$package_name.tar" | wc -l ) -eq 0 ]; then
            echo "Downloading $package_name ⬇️"
            curl --create-dirs --progress-bar "$link" -o "$dir/$package_name.tar"
        fi

        # remove existing directory and extract the downloaded package
        rm -rdf "$dir/$package_name"
        echo "Extracting $package_name 🔄"
        cd "$dir/" && tar -xf "$package_name.tar"
        echo "[$package_name] Ready To Use ✅"
    else
        echo "[$package_name] ✅"
    fi
}

while IFS="" read -r p || [ -n "$p" ]
do
	src_key=$(echo $p | awk -F ':' '{print $1}')
    package_name=$(echo $p | awk -F ':' '{print $2}')
	download_package "$src_key" "$package_name"
done < $input_file