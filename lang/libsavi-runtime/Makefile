PORTNAME=	libsavi-runtime
PORTVERSION=	0.20220912.1
CATEGORIES=	lang
MASTER_SITES=	https://github.com/ponylang/ponyc/archive/refs/tags/

PONYC_VERSION=	0.51.2
DISTVERSION=	${PONYC_VERSION}
DISTNAME=	${DISTVERSION}
DIST_SUBDIR=	${PORTNAME}
WRKSRC=		${WRKDIR}/ponyc-${DISTNAME}

MAINTAINER=	mneumann@ntecs.de
COMMENT=	Runtime for Savi language (based on Pony runtime)
WWW=		https://github.com/savi-lang/savi

LICENSE=	BSD2CLAUSE

BUILD_DEPENDS=	${LOCALBASE}/bin/llvm-config${LLVM_VERSION}:devel/llvm${LLVM_VERSION} \
		${LOCALBASE}/bin/gmake:devel/gmake \
		${LOCALBASE}/bin/cmake:devel/cmake

LLVM_VERSION?=	14

LLVM_CONFIG=	"${LOCALBASE}/bin/llvm-config${LLVM_VERSION}"
LLVM_LINK=	"${LOCALBASE}/bin/llvm-link${LLVM_VERSION}"
CC=		"${LOCALBASE}/bin/clang${LLVM_VERSION}"
CXX=		"${LOCALBASE}/bin/clang++${LLVM_VERSION}"
CFLAGS=		-march=native -mtune=generic -isystem "${WRKSRC}/atomics"

CMAKE_ENV=	LLVM_CONFIG="${LLVM_CONFIG}" \
		CC="${CC}" \
		CXX="${CXX}" \
		CFLAGS="${CFLAGS}"

TARGET_TRIPLE=	"${ARCH}-unknown-${OPSYS:tl}"
SAVIHOME=	${PREFIX}/savi

PLIST=
PLIST_DIRS=	"${SAVIHOME}/lib/libsavi_runtime"
PLIST_FILES=	"${SAVIHOME}/lib/libsavi_runtime/libsavi_runtime-${TARGET_TRIPLE}.bc"


post-extract:
	# There is no stdatomic.h on DragonFly.  Provide a patched version
	# taken from FreeBSD.
	${MKDIR} ${WRKSRC}/atomics
	${CP} ${FILESDIR}/stdatomic.h ${WRKSRC}/atomics

pre-build:
	cd ${WRKSRC} && ${MKDIR} src/libponyrt/build

do-build:
	cd ${WRKSRC} && ${SETENV} ${CMAKE_ENV} \
		cmake -S src/libponyrt \
		-B src/libponyrt/build \
		-DPONY_RUNTIME_BITCODE=true \
		-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
		-DLLVM_VERSION=`${LLVM_CONFIG} --version` \
		-DLLVM_LINK=${LLVM_LINK}
	cd ${WRKSRC} && ${SETENV} ${CMAKE_ENV} \
		cmake --build src/libponyrt/build \
		--target libponyrt_bc

do-install:
	${MKDIR} -p ${STAGEDIR}${SAVIHOME}/lib/libsavi_runtime
	${INSTALL_DATA} ${INSTALL_WRKSRC}/src/libponyrt/build/libponyrt.bc \
		${STAGEDIR}${SAVIHOME}/lib/libsavi_runtime/libsavi_runtime-${TARGET_TRIPLE}.bc

.include <bsd.port.mk>
