if ! source install.conf; then

	read -p "Please enter username:" username

	read -sp "Please enter password:" password

	read -sp "Please repeat password:" password2

	# Check both passwords match
	if [ "$password" != "$password2" ]; then
	    echo "Passwords do not match"
	    exit 1
	fi
    printf "username="$username"\n" >> "install.conf"
  printf "password="$password"\n" >> "install.conf"
fi
