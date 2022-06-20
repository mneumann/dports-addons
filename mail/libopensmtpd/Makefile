# Created by: Michael Neumann <mneumann@ntecs.de>
# $FreeBSD$

PORTNAME=	libopensmtpd
PORTVERSION=	0.4
CATEGORIES=	mail

MAINTAINER=	mneumann@ntecs.de
COMMENT=	library for writing opensmtpd filters

LICENSE=	ISCL

MASTER_SITES=	https://distfiles.sigtrap.nl/

LIB_DEPENDS=	libevent.so:devel/libevent

USES=	gmake

post-patch:
	${RM} ${BUILD_WRKSRC}/Makefile
	${MV} ${BUILD_WRKSRC}/Makefile.gnu ${BUILD_WRKSRC}/Makefile

do-install:
	${INSTALL_LIB} ${WRKSRC}/libopensmtpd.so ${STAGEDIR}${PREFIX}/lib/
	${INSTALL_DATA} ${WRKSRC}/opensmtpd.h ${STAGEDIR}${PREFIX}/include/

.include <bsd.port.mk>
