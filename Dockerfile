FROM centos/python-35-centos7:latest

USER root

COPY . /tmp/src

RUN mv /tmp/src/.s2i/bin /tmp/scripts
    pip install pipsi \
    pipsi install powershift-cli[all]
    
RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

USER 1001

ENV S2I_SCRIPTS_PATH=/usr/libexec/s2i \
    S2I_BASH_ENV=/opt/app-root/etc/scl_enable \
    DISABLE_COLLECTSTATIC=1 \
    DISABLE_MIGRATE=1 \
    BLOG_SITE_NAME='GRUPO10 - SOlUTION SPRINT FASE 4 - MBA ARQUITETURA DE SOLUÇÕES' \
    BLOG_BANNER_COLOR='blue' \
    DATABASE_URL='postgresql://sampledb:sampledb@blog-database:5432/sampledb'   

#RUN /tmp/scripts/assemble

CMD [ "/tmp/scripts/run" ]
