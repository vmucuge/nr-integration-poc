Name:	         foldersize_integration
Version:       VERSION
Release:       1%{?dist}
Summary:       A Python example integration for New Relic

Group:	       System Environment/Base
License:       MIT
URL:           https://github.com/vmucuge/nr-integration-poc
Source0:       foldersize-integration-VERSION.tar.gz
BuildArch:     noarch
BuildRoot:     %{_tmppath}/%{name}-buildroot
Requires:      python2,newrelic-infra

%description
Folder Size monitoring integration for New Relic Infrasctrucutre based on python.
It will check for a folder size and send as a Metric (in MB) to New Relic.

%prep
%setup -q

%install
mkdir -p "$RPM_BUILD_ROOT"
cp -R * "$RPM_BUILD_ROOT"

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/var/db/newrelic-infra/custom-integrations/foldersize_integration-definition.yml
/var/db/newrelic-infra/custom-integrations/foldersize_integration.py
/etc/newrelic-infra/integrations.d/foldersize_integration-config.yml

%post
echo "New Relic Infrastructure Folder Integration Installed"

%doc README.md

%changelog
* Tue Nov 8 2017 VGM <viniciusmucuge@gmail.com> - VERSION
- PoC and Tests 2017-11-8
