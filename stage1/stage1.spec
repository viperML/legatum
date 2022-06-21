Name: stage1
Version: 1.0
Release: 0
License: MIT
Summary: Dummy package
BuildRoot: %{_tmppath}/%{name}-%{version}-build
Source:     %{expand:%%(pwd)}

%description
Dummy text

%prep
cp -af %{SOURCEURL0}/. .

%install
ls -la
find etc -type f -exec install -Dm644 '{}' %{buildroot}/{} \;
find usr -type f -exec install -Dm644 '{}' %{buildroot}/{} \;

%files
%defattr(-,root,root)
/etc/*
/usr/*

%post
. /etc/machine-info
mkdir -p /boot/efi/$KERNEL_INSTALL_MACHINE_ID

%changelog
