SED=`which sed`
CURRENT_DIR=`dirname $0`

echo "Podaj nazwę domeny?"
read DOMAIN

# sprawdzanie poprawnosci domeny!
PATTERN="^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$";
if [[ "$DOMAIN" =~ $PATTERN ]]; then
	DOMAIN=`echo $DOMAIN | tr '[A-Z]' '[a-z]'`
	echo "Tworznie konfiguracji dla:" $DOMAIN
else
	echo "niepoprawna nazwa domeny"
	exit 1
fi

echo "Folder twojej domeny to /var/www/$DOMAIN"
read PUBLIC_FOLDER

CONFIG=$CURRENT_DIR/$DOMAIN
sudo cp $CURRENT_DIR/nginx.template $CONFIG
sudo $SED -i "s/{{DOMAIN}}/$DOMAIN/g" $CONFIG
sudo $SED -i "s/{{PUBLIC_FOLDER}}/$PUBLIC_FOLDER/g" $CONFIG
