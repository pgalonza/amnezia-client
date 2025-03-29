mkdir -p /opt/amnezia/wireguard
cd /opt/amnezia/wireguard

if [ ! -f /opt/amnezia/wireguard/wireguard_server_private_key.key ]; then
    WIREGUARD_SERVER_PRIVATE_KEY=$(wg genkey)
fi
echo $WIREGUARD_SERVER_PRIVATE_KEY > /opt/amnezia/wireguard/wireguard_server_private_key.key

if [ ! -f /opt/amnezia/wireguard/wireguard_server_private_key.key ]; then
    WIREGUARD_SERVER_PUBLIC_KEY=$(echo $WIREGUARD_SERVER_PRIVATE_KEY | wg pubkey)
fi
echo $WIREGUARD_SERVER_PUBLIC_KEY > /opt/amnezia/wireguard/wireguard_server_public_key.key

if [ ! -f /opt/amnezia/wireguard/wireguard_psk.key ]; then
    WIREGUARD_PSK=$(wg genpsk)
fi
echo $WIREGUARD_PSK > /opt/amnezia/wireguard/wireguard_psk.key

WIREGUARD_SERVER_IP=$(echo $WIREGUARD_SUBNET_IP | sed 's/\.0$/\.1/')

cat > /opt/amnezia/wireguard/wg0.conf <<EOF
[Interface]
PrivateKey = $WIREGUARD_SERVER_PRIVATE_KEY
Address = $WIREGUARD_SERVER_IP/$WIREGUARD_SUBNET_CIDR
ListenPort = $WIREGUARD_SERVER_PORT
EOF
