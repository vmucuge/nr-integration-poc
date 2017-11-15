Name:          foldersize_integration
Version:       VERSION
Release:       {?dist}
Summary:       A Python example integration for New Relic

Group:	       System Environment/Base
License:       MIT
URL:           https://github.com/vmucuge/nr-integration-poc
Source0:       %{name}-VERSION.tar.gz
BuildArch:     x86_64
Requires:      python2,newrelic-infra

%description
Folder Size monitoring integration for New Relic Infrasctrucutre based on python.
It will check for a folder size and send as a Metric (in MB) to New Relic.

%prep
%setup -q

%install
mkdir -p $RPM_BUILD_ROOT/var/db/newrelic-infra/custom-integrations
mkdir -p $RPM_BUILD_ROOT/etc/newrelic-infra/integrations.d
cp -R * "$RPM_BUILD_ROOT"
rm -f $RPM_BUILD_ROOT/var/db/newrelic-infra/custom-integrations/foldersize_integration.pyc
rm -f $RPM_BUILD_ROOT/var/db/newrelic-infra/custom-integrations/foldersize_integration.pyo

%clean
rm -rf $RPM_BUILD_ROOT
rm -rf %{_tmppath}/%{name}
rm -rf %{_topdir}/BUILD/%{name}

%files
%defattr(-,root,root,-)
/var/db/newrelic-infra/custom-integrations/foldersize_integration-definition.yml
/etc/newrelic-infra/integrations.d/foldersize_integration-config.yml
%attr(755, root, root) /var/db/newrelic-infra/custom-integrations/foldersize_integration.py
%exclude /var/db/newrelic-infra/custom-integrations/foldersize_integration.pyo
%exclude /var/db/newrelic-infra/custom-integrations/foldersize_integration.pyc

%doc
%changelog
* Tue Nov 8 2017 VGM <viniciusmucuge@gmail.com> - VERSION
- PoC and Tests 2017-11-8
