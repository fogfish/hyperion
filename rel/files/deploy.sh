##
## node deployment script
##  ${PREFIX} - root installation folder
##  ${REL}    - absolute path to release
##  ${APP}    - application name
##  ${VSN}    - application version
set -u
set -e

## changes node name
FILE=${REL}/releases/${VSN}/vm.args
HOST=`curl http://169.254.169.254/latest/meta-data/public-hostname`
#HOST=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
NODE=`sed -n -e "s/-name \(.*\)@.*/\1/p" ${FILE}`
sed -i -e "s/@\(127.0.0.1\)/@${HOST}/g" ${FILE}

##
## build service wrapper
if [ ! -a /etc/init.d/${APP} ] ; then
echo -e "#!/bin/bash\nexport HOME=/root\n${PREFIX}/${APP}/bin/${APP} \$1" >  /etc/init.d/${APP}
chmod ugo+x /etc/init.d/${APP}
fi

set +u
set +e
