# Fishallure
======


![Build Status](https://codeship.com/projects/7d3602c0-284e-0134-eaa6-0e5bf792534a/status?branch=master)
![Code Climate](https://codeclimate.com/github/bendarcy22/fishallure.png)
[![Coverage Status](https://coveralls.io/repos/github/bendarcy22/fishallure/badge.svg?branch=master)](https://coveralls.io/github/bendarcy22/fishallure?branch=master)

Demo Site: http://fishallure.herokuapp.com/


FishAllure is a Ruby on Rails web app that allows fisherman to catalog all sorts of information about what fish they caught, what lure they used and where they caught the fish. FishAllure allows fishermen to post photos of their catch via CarrierWave, and integrates the Mapbox API, via the Leaflet library, which allows fisherman to visually see where fish are being caught and to pin markers themselves to where they caught the fish.

I've always wanted to be able to track important fishing information, such as what fish are around, where they are being caught and what they are being caught on. FishAllure takes all this pertinent information and makes it searchable and easy to understand.

## Download
------

```git clone https://github.com/bendarcy22/fishallure.git
cd fishallure
bundle install
rake db:create db:migrate```
