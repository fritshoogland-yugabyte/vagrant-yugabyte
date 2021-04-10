# packer scripts for building virtual machines with the yugabyte database installed

### Overview

This is a packer project that contains the scripts to build virtual machines for testing yugabyte.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build any of these Vagrant boxes:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/)

## Building the Vagrant boxes with Packer

All variables are in the json files.
To start the build, edit the 'b' file for the correct OS to build, and then execute:

$ ./b

The 'b' (build) script contains the packer command for building a specific 'box' for vagrant.

## What does it do? (what does packer do)

* Packer downloads the installation ISO,
* Sets up an http server and boots the installation ISO using virtualbox,
* Then runs kickstart to automatically install linux using a kickstart file from the http server,
* Then sets up the linux installation for use with vagrant (root password vagrant, vagrant user with password vagrant, and set the vagrant insecure key),
* And the runs a couple of scripts to further configure the operating system for use with the oracle database.

## troubleshooting

logging
$ export PACKER_LOG=1
$ export PACKER_LOG_PATH="packerbuild.log"

ask
packer build -on-error=ask 

breakpoint; add to json file:
    {
      "type": "breakpoint"
    } ]
