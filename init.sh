if [ $( cat ~/.zshrc | grep .my_cloud.sh | wc -l) -eq 0 ] ; then
	chmod +x .my_cloud.sh
	cp -f .my_cloud.sh ~
	echo "~/.my_cloud.sh" >> ~/.zshrc
	touch ~/files.nsx
else
	echo "already installed"
fi