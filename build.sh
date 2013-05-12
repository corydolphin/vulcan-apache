 #!/bin/bash
echo "-----> Beginning build script"
echo "-----> Building PCRE"
cd "pcre-8.32"
./configure --prefix=/app/vendor/apache-bench/pcre-8.32
make
make install
echo "-----> Built PCRE"
cd ..

echo "-----> Building httpd"
cd "httpd-2.4.4"
./configure --with-included-apr --with-pcre=/app/vendor/apache-bench/pcre-8.32 --prefix=/app/vendor/apache-bench/apache-2.4.4
make
make install
echo "-----> Finished build script"