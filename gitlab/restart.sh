#!/bin/bash
# https://github.com/sameersbn/docker-gitlab

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#------------------------------------------------------------------------------
# Edit these config first
VOL_HOST=$DIR/volume
CERT_DIR=$DIR/certs
GITLAB_HOST=localhost
GITLAB_KEY=need-a-long-and-random-string-as-key
#------------------------------------------------------------------------------

# FIXME: CHECK if certs dir exists
# FIXME: check if the config is set

echo "# Step 1. Launch a postgresql container"
docker rm -f gitlab-postgresql
docker run -d --restart always \
    --name gitlab-postgresql \
    --env 'DB_NAME=gitlabhq_production' \
    --env 'DB_USER=gitlab' --env 'DB_PASS=password' \
    --env 'DB_EXTENSION=pg_trgm' \
    --volume /srv/docker/gitlab/postgresql:/var/lib/postgresql \
    sameersbn/postgresql:9.4-21

echo "# Step 2. Launch a redis container"
docker rm -f gitlab-redis
docker run -d --restart always \
    --name gitlab-redis \
    --volume $VOL_HOST/redis:/var/lib/redis \
    sameersbn/redis:latest

echo "# Step 3. Launch the gitlab container"
docker rm -f gitlab
docker run -d --restart always \
    --name gitlab \
    --link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
    --publish 10022:22 --publish 10080:80 --publish 10443:443 \
    --env 'GITLAB_SSH_PORT=10022' --env 'GITLAB_PORT=10443' \
    --env 'GITLAB_HTTPS=true' --env 'SSL_SELF_SIGNED=true' \
    --env GITLAB_PROJECTS_LIMIT=1024 \
    --env GITLAB_SECRETS_DB_KEY_BASE=$GITLAB_KEY \
    --env GITLAB_HOST=$GITLAB_HOST \
    --volume $CERT_DIR:/home/git/data/certs \
    --volume $VOL_HOST/gitlab:/home/git/data \
    sameersbn/gitlab:8.10.1

# MEMO: Ldap settings
#    --env LDAP_ENABLED=true \
#    --env LDAP_HOST=bladetpe.emotibot.com.cn \
#    --env LDAP_PORT=389 \
#    --env LDAP_BIND_DN='cn=admin,dc=emotibot,dc=com' \
#    --env LDAP_PASS=<ldappass>\
#    --env LDAP_ALLOW_USERNAME_OR_EMAIL_LOGIN=true \
#    --env LDAP_UID='uid' \
#    --env LDAP_BASE="dc=emotibot,dc=com" \
#    --env LDAP_ACTIVE_DIRECTORY=false \

echo "Wait a few minutes (if it's the 1st run)"
echo "Goto http://$GITLAB_HOST:10080"

