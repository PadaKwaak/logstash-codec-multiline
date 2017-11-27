FROM logstash:latest

RUN DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get --yes install procps git

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
 && curl -sSL https://get.rvm.io -o /tmp/rvm.sh \
 && cat /tmp/rvm.sh | bash -s stable --rails

SHELL ["/bin/bash", "-c"]

#RUN apt-get --yes install gem

RUN source /usr/local/rvm/scripts/rvm \
 && rvm install jruby \
 && gem install bundler \
 && rm /tmp/rvm.sh

RUN git clone https://github.com/elastic/logstash-devutils

RUN source /usr/local/rvm/scripts/rvm \
  && rvm use jruby \
  && pushd logstash-devutils \
  && bundle install \
  && popd

# Run source /usr/local/rvm/scripts/rvm && rvm use jruby
# bundle install
# bundle exec rspec --seed=11325