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

RUN SECRET_KEY_BASE='bin/rails secret'

#END:app

#START:init
USER root
CMD ["/sbin/my_init"]
#END:init
