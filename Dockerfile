FROM mekler/ruby:ruby
ENV LANG C.UTF-8
MAINTAINER Paco Mekler <elmekler@opi.la>
RUN mkdir -p /srv/www/chucky && useradd -ms /bin/bash deploy && locale-gen es_MX.UTF-8
COPY . /srv/www/chucky
RUN chown -R deploy:deploy /srv/www/chucky/.
RUN gem install bundler --without development test
WORKDIR /srv/www/chucky/
RUN bundle install
EXPOSE 3000
USER deploy
CMD ["puma", "-p", "3000"]
