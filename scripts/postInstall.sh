#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 10s;

docker-compose down;

sed -i "s~server: localhost~server: ${SMTP_HOST}\n  port: ${SMTP_PORT}\n  use ssl: False\n  use tls: False~g" ./dabackup/config/config.yml
sed -i "s~no-reply@example.com~${SMTP_FROM}~g" ./dabackup/config/config.yml
sed -i "s~webmaster@localhost~${ADMIN_EMAIL}~g" ./dabackup/config/config.yml

docker-compose up -d;

sleep 60s;