if ! source install.conf; then

	read -p "Please enter username:" username

	read -sp "Please enter password:" password

	
"
fi

useradd -mG wheel 
