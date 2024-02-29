#!/bin/bash

# file containing source keys:package names
input_file=$nsx_path/files.nsx

echo $nsx_path
# directory where packages will be downloaded
dir=~/goinfre

# function to download a package
download_package() {
    local src_key=$1
    local package_name=$2

    # check if the package is already present in the directory
    if [ $(ls "$dir" | grep -x "$package_name" | wc -l ) -eq 0 ] ; then
        echo "[$package_name] Not Found ❌, Let's Get It."
        # check if the "mgetter" binary exists
        if [ ! -e ~/mgetter ]; then
            make -C $nsx_path/mscrapper_c all clean
        fi

        # get download link using "mgetter" binary
        link=$($nsx_path/mscrapper_c/mgetter "$src_key")
		tarname=$(printf $link | tr '/' '\n' | tail -1)

        # create directory for the package if it doesn't exist
        mkdir -p "$dir/$package_name"

        # download the package if not already present
        if [ $(ls ~/goinfre | grep "$package_name.tar" | wc -l ) -eq 0 ]; then
            echo "Downloading $package_name ⬇️"
            curl --create-dirs --progress-barc "$link" -o "$dir/$tarname"
        fi

        # remove existing directory and extract the downloaded package
        rm -rdf "$dir/$package_name"
        echo "Extracting $tarname 🔄"
        tar -xf "$dir/$tarname" -C $dir
        echo "[$package_name] Ready To Use ✅"
    else
        echo "[$package_name] ✅"
    fi
}

while IFS="" read -r p || [ -n "$p" ]
do
	if [ $p == ">VisualStudio" ]; then
		src_key="82xgh4ycwwp06jw"
		package_name="Visual Studio.app"
	else
		src_key=$(echo $p | awk -F ':' '{print $1}')
		package_name=$(echo $p | awk -F ':' '{print $2}')
	fi	
	download_package "$src_key" "$package_name"
done < $input_file