#!/bin/bash

git clone https://github.com/adityareddy/lunanode-flocker-plugin
/opt/flocker/bin/pip install lunanode-flocker-plugin/
/opt/flocker/bin/pip list | grep -i huawei-oceanstor-flocker-plugin