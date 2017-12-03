![Description](https://pbs.twimg.com/media/CHxoz_UUkAA3_Gt.png)

# Installation
## Debian
    sudo apt-get -y install python-software-properties
    sudo add-apt-repository -y ppa:saltstack/salt
    sudo apt-get update
    sudo apt-get -y install salt-master ( of salt-minion)

or

    wget -qO- http://sacha.ligthert.net/salt-minion | sh
    wget -qO- http://sacha.ligthert.net/salt-master | sh
## FreeBSD
    pkg -r py27-salt-2014.1.5
    echo "81.171.33.94 salt" >> /etc/hosts
    echo "master: salt" >>  /usr/local/etc/salt/minion
    echo 'salt_minion_enable="YES"' >> /etc/rc.conf
    echo 'salt_minion_paths="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"' >> /etc/rc.conf
## Server
    mkdir /srv/salt

In `/etc/salt/master`:

    file_roots:
     base:
       - /srv/salt
    hash_type: md5

## Client
    echo "81.171.33.94 salt" >> /etc/hosts

In `/etc/salt/minion`:

    master: salt
    hash_type: md5

## Fun Stuff
### All grains
`salt '*' grains.items`
### All Stuff
`salt '*' status.all_status`


# Updating a package on every machine
    salt \* pkg.install lxc-docker refresh=true

# Updating saltstack on all the minions
    salt \* file.replace /etc/salt/minion pattern='master_type: str' repl='master_type: standard'
    salt \* cmd.run 'apt-get update'
    salt \* cmd.run 'apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y salt-minion'

# Massive errors on highstate from minions after an upgrade?
    /etc/init.d/salt-minion stop
    cd /var/cache/salt/minion
    rm -rf *
    /etc/init.d/salt-minion start
