# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Simple udev-based automounter for removable USB media"
HOMEPAGE="https://github.com/projg2/uam/"
SRC_URI="https://github.com/projg2/uam/releases/download/${P}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	acct-group/plugdev
	virtual/udev"
BDEPEND="virtual/pkgconfig"

pkg_postinst() {
	elog "To be able to access uam-mounted filesystems, you have to be"
	elog "a member of the 'plugdev' group."
	elog
	elog "Note that uam doesn't provide any way to allow unprivileged user"
	elog "to manually umount devices. The upstream suggested solution"
	elog "is to use [sys-apps/pmount]. If you don't feel like installing"
	elog "additional tools, remember to sync before removing your USB stick."
	elog
	elog "If you'd like uam to mount ejectable media like CDs/DVDs, you need"
	elog "to enable in-kernel media polling, e.g.:"
	elog "	echo 5000 > /sys/module/block/parameters/events_dfl_poll_msecs"
	elog "where 5000 would mean a poll will occur every 5 seconds."
	elog
	elog "If you'd like to receive libnotify-based notifications, you need"
	elog "to install the [x11-misc/sw-notify-send] tool."

	udev_reload
}

pkg_postrm() {
	udev_reload
}
