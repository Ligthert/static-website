# Exam notes, Why?
I need to write things down for tomorrows exam or else I won't make it. :-\

# Installation logs
    If the installation failed, you can review the installation log at /system/volatile/install_log.
    If the installation succeeded, you can find the log at /system/volatile/install_log before you reboot the system or at /var/sadm/system/logs/install_log after you reboot.

# Supported hardware
* x64, anything in the HCL
* SPARC, T and M series, OBP 4.17

# Steps in the graphic installer
1. Welcome
2. Disk
3. Time Zone
4. Users
5. Installation
6. Finish

# Verifying the install
Hostname
* System version and release
* Boot disk configuration
* Physical memory complement
* Network service configuration
* Network interface configuration

# Verifying network install
The network services _physical:default_ and _physical:nwam_ (Network Auto-Magic) provide for static and dynamic IP configuration, respectivly. Both can be disabled.

# Run Levels
* 0) Firmware
* 1) System administrator
* 2) Multiuser (allows remote connections)
* 3) Multiuser with services
* 4) Unspecified
* 5) Shutdown and power off
* 6) Reboot
* S) Single user

# beadm
    # beadm

    Usage:
      beadm subcommand cmd_options

      subcommands:

      beadm activate beName
      beadm create [-a] [-d description]
          [-e non-activeBeName | beName@snapshot]
          [-o property=value] ... [-p zpool] beName
      beadm create beName@snapshot
      beadm destroy [-fF] beName | beName@snapshot
      beadm list [[-a] | [-d] [-s]] [-H] [beName]
      beadm mount beName mountpoint
      beadm rename beName newBeName
      beadm unmount [-f] beName

# dladm object names
* addr
* if
* ip
* ipmp
* vni

# ipadm subcommands
* show-if
* show-addr
* create-ip
* create-addr
* down-addr
* up-addr
* delete-addr
* delete-ip

# Zones
* zonecfg, creates and configure zones
* zoneadm, installs, powers on/off zones
* zlogin, allows you to login into the zone

# Milestones
The milestones that can be specified at boot time are:
* none
* single-user
* multi-user
* multi-user-server
* all

#Aaaaahw fuck it!
Here are the exam answers... http://www.aiotestking.com/oracle/what-is-the-correct-setting-of-umask-and-where-should-it-be-set-to-allow-jack-to-create-a-shell-script-using-the-vi-editor-that-is-executable-by-default/
