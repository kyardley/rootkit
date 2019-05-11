#!/usr/bin/env bash
sudo apt-get install john

wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2 -P /home/sansforensics/wordlists/

bzip2 -d /home/sansforensics/wordlists/rockyou.txt.bz2
