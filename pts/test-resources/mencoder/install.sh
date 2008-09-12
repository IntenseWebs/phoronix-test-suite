#!/bin/sh

tar -xjf MPlayer-1.0rc2.tar.bz2

THIS_DIR=$(pwd)
mkdir $THIS_DIR/mplayer_

cd MPlayer-1.0rc2/
./configure --prefix=$THIS_DIR/mplayer_ > /dev/null
make -j $NUM_CPU_JOBS
make install
cd ..
rm -rf MPlayer-1.0rc2/

echo "#!/bin/sh

echo \"#!/bin/sh
./mplayer_/bin/mencoder \$TEST_EXTENDS/pts-trondheim.avi -o /dev/null -ovc lavc -oac copy -lavcopts vcodec=mpeg4:threads=\$NUM_CPU_CORES:mbd=2:trell=1:v4mv=1:vstrict=1\" > encode-process
chmod +x encode-process

/usr/bin/time -f \"Encoding Time: %e Seconds\" ./encode-process 2>&1 | grep Seconds" > mencoder
chmod +x mencoder
