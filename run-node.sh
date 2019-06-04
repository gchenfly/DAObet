NODE_PATH=$HOME/.dao-node
NODE_IMAGE='mixbytes/haya:v0.1.1-BET'
CONFIG_URL='https://explorer.dao.casino/config'


mkdir -p $NODE_PATH/config
mkdir -p $NODE_PATH/state


curl -sk $CONFIG_URL/config.ini -o $NODE_PATH/config/config.ini
curl -sk $CONFIG_URL/genesis.json -o $NODE_PATH/config/genesis.json
curl -sk $CONFIG_URL/logger.json -o $NODE_PATH/config/logger.json


docker run -d --cap-add IPC_LOCK \
    --env EOSIO_ROOT=/opt/haya \
    --env LD_LIBRARY_PATH=/usr/local/lib \
    --env PATH=/opt/haya/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    --name dao-node \
    --network host \
    --volume $NODE_PATH:/opt/dao:rw \
    $NODE_IMAGE \
    /opt/haya/bin/haya-node \
    --config-dir=/opt/dao/config \
    --genesis-json=/opt/dao/config/genesis.json \
    --logconf=/opt/dao/config/logger.json