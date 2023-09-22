FROM phusion/passenger-ruby32

RUN rm /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down
RUN rm -f /etc/service/redis/down
ADD config/nginx.conf /etc/nginx/sites-enabled/sistema_teste.conf

ENV TZ=America/Fortaleza

#START:app
USER app
RUN mkdir /home/app/sistema_teste
WORKDIR /home/app/sistema_teste

ENV RAILS_ENV=production
ENV BUNDLE_WITHOUT="development test"
COPY --chown=app:app Gemfile Gemfile.lock /
COPY --chown=app:app . .
RUN bundle install

RUN SECRET_KEY_BASE=66d3052c8cde46bb449ac08acfb7b16d47b17d5713a100c970e6db7156e51b94fc15611120093c1dcbb03013ba2d5de9b9aea051999b18836628522b636cf38e

#END:app

#START:init
USER root
CMD ["/sbin/my_init"]
#END:init
