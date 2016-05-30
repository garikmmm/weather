#!/bin/bash

cd /vagrant
gem install bundler
rbenv rehash
bundle install
