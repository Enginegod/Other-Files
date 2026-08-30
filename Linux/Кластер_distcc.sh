distcc ccache 

tar -czvf archive.tar.gz /путь/к/папке


sudo systemctl enable distccd
sudo systemctl start distccd


export IGNORE_CC_MISMATCH=1
export CCACHE_PREFIX="distcc"
export DISTCC_HOSTS="localhost/4 192.168.1.166/2"
#Здесь localhost/4 означает использование 4 ядер локальной машины, а остальные IP — по 8 потоков на удаленных серверах.

make -j$(($(nproc) + $(distcc -j))) V=s

make CC="ccache gcc" CXX="ccache g++" -j$(($(nproc) + $(distcc -j))) V=s



nc -vz 192.168.1.166 3632