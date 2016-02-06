##
## node deployment script
##  ${PREFIX} - root installation folder
##  ${REL}    - absolute path to release
##  ${APP}    - application name
##  ${VSN}    - application version
set -u
set -e


##
## discover version of erlang release
VERSION=`cat ${REL}/releases/start_erl.data`
SYS_VSN=${VERSION% *}
APP_VSN=${VERSION#* }


##
## changes node name
FILE=${REL}/releases/${APP_VSN}/vm.args

## discover public host name on aws
# HOST=`curl http://169.254.169.254/latest/meta-data/public-hostname`

## discover private ip on aws
# HOST=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

## update 
# NODE=`sed -n -e "s/-name \(.*\)@.*/\1/p" ${FILE}`
# sed -i -e "s/@\(127.0.0.1\)/@${HOST}/g" ${FILE}

##
## build service wrapper
if [ ! -a /etc/init.d/${APP} ] ; 
then
echo -e "#!/bin/bash\nexport HOME=/root\n${REL}/bin/${APP} \$1" >  /etc/init.d/${APP}
chmod ugo+x /etc/init.d/${APP}
fi

##
## deploy global config
test ! -d /etc/hyperion && mkdir -p /etc/hyperion

set +u
set +e
