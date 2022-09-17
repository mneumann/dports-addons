PORTNAME=	savi
PORTVERSION=	0.20220916.0
CATEGORIES=	lang

DISTVERSION=	v${PORTVERSION}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	mneumann@ntecs.de
COMMENT=	Fast actor-based language
WWW=		https://github.com/savi-lang/savi

LICENSE=	BSD3CLAUSE

BUILD_DEPENDS=	${LOCALBASE}/bin/crystal:lang/crystal \
		${LOCALBASE}/bin/llvm-config${LLVM_VERSION}:devel/llvm${LLVM_VERSION} \
		${LOCALBASE}/lib/libgc-threaded.a:devel/boehm-gc-threaded \
		${LOCALBASE}/lib/libevent.a:devel/libevent \
		${LOCALBASE}/lib/libpcre.a:devel/pcre

TARGET_TRIPLE=	"${ARCH}-unknown-${OPSYS:tl}"
RUN_DEPENDS=	${SAVIHOME}/lib/lib_saviruntime/libsavi_runtime-${TARGET_TRIPLE}.bc:lang/libsavi-runtime

LIB_DEPENDS=	libxml2.so:textproc/libxml2 \
		libclang.so:devel/llvm${LLVM_VERSION} \
		libLLVM-${LLVM_VERSION:C/^([6-9])0/\1/:S/-devel/15/}.so:devel/llvm${LLVM_VERSION}

USES=		gmake

USE_GITHUB=	yes
GH_ACCOUNT=	savi-lang

LLVM_VERSION?=	14

LLVM_CONFIG=	"${LOCALBASE}/bin/llvm-config${LLVM_VERSION}"
LLVM_LINK=	"${LOCALBASE}/bin/llvm-link${LLVM_VERSION}"
CC=		"${LOCALBASE}/bin/clang${LLVM_VERSION}"
CXX=		"${LOCALBASE}/bin/clang++${LLVM_VERSION}"
CFLAGS=		-march=native -mtune=generic -isystem "${WRKSRC}/atomics"

MAKE_ENV=	SAVI_VERSION="${PORTVERSION}" \
		BUILD_LIBSAVI_RUNTIME="" \
		LLVM_PATH="${LOCALBASE}/llvm${LLVM_VERSION}" \
		CLANGXX="${LOCALBASE}/bin/clang++${LLVM_VERSION}" \
		CLANG="${LOCALBASE}/bin/clang${LLVM_VERSION}" \
		LIB_GC="${LOCALBASE}/lib/libgc-threaded.a" \
		LIB_EVENT="${LOCALBASE}/lib/libevent.a" \
		LIB_PCRE="${LOCALBASE}/lib/libpcre.a" \
		LIB_CXX_KIND=""

ALL_TARGET=	build/savi-release

SAVIHOME=	${PREFIX}/savi
PLIST_SUB=	SAVIHOME="${SAVIHOME}"

do-install:
	${MKDIR} -p ${STAGEDIR}${SAVIHOME}/bin
	${MKDIR} -p ${STAGEDIR}${SAVIHOME}/core
	${INSTALL_PROGRAM} ${INSTALL_WRKSRC}/build/savi-release ${STAGEDIR}${SAVIHOME}/bin/savi
	cd ${INSTALL_WRKSRC}/core && ${COPYTREE_SHARE} . ${STAGEDIR}${SAVIHOME}/core

.include <bsd.port.mk>
