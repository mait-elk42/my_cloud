if [ $( cat ~/.zshrc | grep .my_cloud.sh | wc -l) -eq 0 ] ; then
	chmod +x .my_cloud.sh
	echo "export nsx_path=$(pwd)" >> ~/.zshrc
	echo "alias nsx=$(pwd)/.my_cloud.sh" >> ~/.zshrc
else
	echo "already installed"
fi