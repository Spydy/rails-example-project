FROM ruby:2.6.0

WORKDIR /app

COPY . . 

ENV LC_ALL=C.UTF-8

RUN chmod 777 -R /tmp/ && \
    apt-get install curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs && \
    bundle install && \
    rails db:migrate RAILS_ENV=production SECRET_KEY_BASE=production_test_key && \
    npm install yarn -g && \
    rake assets:precompile && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove curl && \
    useradd -m app && \
    chown -R app:app .

USER app

CMD [ "rails", "s", "-e", "production" ] 
