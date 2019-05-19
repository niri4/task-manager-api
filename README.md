# Task Manager
[![Build Status](https://travis-ci.org/niri4/task-manager-api.svg?branch=master)](https://travis-ci.org/niri4/task-manager-api)


1 rake db:create
2 rake db:migrate
3 for test enviournment bin/rails db:migrate RAILS_ENV=test
4 rake db:seed # to create Default user, status, label
5 run test rspec
6 rails s dor development


# API Doc!
- header "Authorization: Authorization key"
- GET 'api/v1/tasks' # list of all task
- POST 'api/v1/task' # to create
 - PUT 'api/v1/task/:id' # to update
 -
