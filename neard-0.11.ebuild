# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit base

DESCRIPTION="Provides a Near Field Communication (NFC) management daemon"
HOMEPAGE="https://01.org/linux-nfc/"
SRC_URI="mirror://kernel/linux/network/nfc/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="debug tools"

RDEPEND=">=dev-libs/glib-2.28
        dev-libs/libnl
 >=sys-apps/dbus-1.2.24"

DEPEND="${RDEPEND}"

src_configure() {
 econf \
  --localstatedir=/var \
  $(use_enable debug) \
  $(use_enable tools)
}

src_install() {
 emake DESTDIR="${D}" install || die "emake install failed"

 keepdir /var/lib/${PN} || die
 newinitd "${FILESDIR}"/${PN}.initd2 ${PN} || die
 newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
}
