#!/bin/sh

set -ex

if [ ! -e mruby ]; then
    curl http://forum.mruby.org/download/source/mruby-1.2.0.tar.gz | tar zxf -
fi

if [ ! -e onepassword_data ]; then
    curl https://cache.agilebits.com/security-kb/freddy-2013-12-04.tar.gz | tar zxf -
fi

cp build_config.rb mruby/build_config.rb
(cd mruby && make test)
