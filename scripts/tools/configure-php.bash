PHP_VERSIONS=$(update-alternatives --list php | grep -Eo '[0-9]\.[0-9]')

update-php-config() {
    if [ -d /etc/php/"$1"/fpm ]; then
        sed -i "s|^$2 = .*|$2 = $3|g" /etc/php/"$1"/fpm/php.ini
    fi

    if [ -d /etc/php/"$1"/apache2 ]; then
        sed -i "s|^$2 = .*|$2 = $3|g" /etc/php/"$1"/apache2/php.ini
    fi

    if [ -d /etc/php/"$1"/cli ]; then
        sed -i "s|^$2 = .*|$2 = $3|g" /etc/php/"$1"/cli/php.ini
    fi
}

echo "$PHP_VERSIONS" | while read -r line; do
    update-php-config "$line" "display_errors" "On"
done