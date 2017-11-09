FROM centos

MAINTAINER Vinicius Mucuge <viniciusmucuge@gmail.com>

ENV NRINTEGRATION foldersize_integration
ENV VERSION "1.0.1"

ENV NRDIR "nr-integrations"
ENV INTDIR "/var/db/newrelic-infra/custom-integrations"
ENV CONFDIR "/etc/newrelic-infra/integrations.d"

RUN mkdir -p "/etc/newrelic-infra/integrations.d"
RUN mkdir -p "/var/db/newrelic-infra/custom-integrations"
RUN mkdir -p /opt/scripts
ADD ./scripts/* /opt/scripts/
RUN chmod +x /opt/scripts/*
ADD ./nr-integrations/var/db/newrelic-infra/custom-integrations/foldersize_integration.py /var/db/newrelic-infra/custom-integrations/foldersize_integration.py
ADD ./nr-integrations/var/db/newrelic-infra/custom-integrations/foldersize_integration-definition.yml /var/db/newrelic-infra/custom-integrations/foldersize_integration-definition.yml
ADD ./nr-integrations/etc/newrelic-infra/integrations.d/foldersize_integration-config.yml /etc/newrelic-infra/integrations.d/foldersize_integration-config.yml
RUN find /var/db/newrelic-infra
RUN chmod +x /var/db/newrelic-infra/custom-integrations/foldersize_integration.py
RUN echo "== Installing Epel Release Repo"
RUN yum install -y epel-release
RUN echo "== Installing NR Infrastructure"
RUN curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
RUN yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
RUN echo "license_key: d42e0f214385d45bb811bb096dbf6992e9b50981" > /etc/newrelic-infra.yml
RUN yum install -y newrelic-infra ansible
RUN cat /etc/newrelic-infra.yml
ENTRYPOINT [ "/opt/scripts/entrypoint.sh" ]
