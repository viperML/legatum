Name: stage2
Version: 1.0
Release: 0
License: MIT
Summary: Dummy package
BuildRoot: %{_tmppath}/%{name}-%{version}-build
Source:     %{expand:%%(pwd)}

Requires: kernel-default, kernel-firmware, zfs, cryptsetup, lvm2, dracut
Requires: vim, which

%description
Dummy text

%changelog
