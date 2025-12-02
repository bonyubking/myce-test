#!/bin/bash
ssh -i ~/.ssh/terra_myce_keypair.pem \
  -o ProxyCommand="ssh -i ~/.ssh/terra_myce_keypair.pem -W %h:%p ec2-user@13.124.100.6" ec2-user@10.0.30.231
