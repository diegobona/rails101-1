# Using a image made by daocloud
FROM library/rails:5.0.1

# Author
MAINTAINER Liangchaob <liangchaob@163.com> 

# excuse RUN
# RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
RUN gem install rubygems-bundler
RUN gem regenerate_binstubs
RUN gem update bundler
RUN gem install rake

# Add app stuff into daocloud server
COPY . /app

# Cgdir to app
WORKDIR /app

# Excuse bundle
RUN bundle install

# Open Ports
EXPOSE 80

# Update db schema
CMD RAILS_ENV=production rake db:migrate

# Start rails server in production model
ENTRYPOINT rails s -e production -b 0.0.0.0 -p 80
