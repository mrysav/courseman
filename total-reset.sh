#!/bin/bash

rake db:drop db:create db:migrate
rake db:seed
