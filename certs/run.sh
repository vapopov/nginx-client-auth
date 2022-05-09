
# ----------------------- CA certificate ---------------------------

openssl genrsa -out ca-key.pem 2048
openssl req -x509 -sha256 -new -config client.config -nodes -key ca-key.pem -days 7300 -out ca-crt.pem

echo 00 > ca-crt.srl

# --------------------- client ---------------------
openssl genrsa -out client-key.pem 2048

openssl req -sha256 -new \
    -config client-csr.config \
    -key client-key.pem \
    -nodes \
    -out client-csr.pem

openssl x509 -sha256 \
    -CA ca-crt.pem \
    -CAkey ca-key.pem \
    -req -days 3650 \
    -in client-csr.pem \
    -extfile client-crt.config \
    -out client-crt.pem


# --------------------- server ---------------------
openssl genrsa -out server-key.pem 2048

openssl req -sha256 -new \
    -config server-csr.config \
    -key server-key.pem \
    -nodes \
    -out server-csr.pem

openssl x509 -sha256 \
    -CA ca-crt.pem \
    -CAkey ca-key.pem \
    -req -days 3650 \
    -in server-csr.pem \
    -extfile server-crt.config \
    -out server-crt.pem

