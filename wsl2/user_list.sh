#!/bin/bash
cat /etc/passwd |grep /home/ |cut -d: -f1
