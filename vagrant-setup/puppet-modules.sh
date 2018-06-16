#!/bin/bash

PUPPET=/opt/puppetlabs/bin/puppet

modulelist=$1
environment=$2

if [ -e $modulelist ]; then
    while read module; do
        $PUPPET module install $module --environment $environment
    done <$modulelist
fi
