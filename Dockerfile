FROM ruby:2.6.1
RUN apt-get update -qq
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -yq libssl1.0-dev mysql-client vim node-gyp nodejs build-essential 
RUN apt-get install -y npm
RUN mkdir /foreign-exchange

WORKDIR /foreign-exchange
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /foreign-exchange
WORKDIR /foreign-exchange
#RUN RAILS_ENV=production bundle exec rails assets:precompile --trace
RUN RAILS_ENV=production bundle exec rails assets:precompile
#RUN /etc/init.d/mysql start
#CMD ["rails","server","-b","0.0.0.0"]
