--- Makefile.gnu.orig	2019-11-15 11:39:00 UTC
+++ Makefile.gnu
@@ -14,6 +14,7 @@ mkfile_path := ${abspath ${lastword ${MA
 CURDIR := ${dir ${mkfile_path}}
 
 CFLAGS+=	-fPIC
+CFLAGS+=	-I${LOCALBASE}/include
 CFLAGS+=	-I${CURDIR} -I${CURDIR}/openbsd-compat/
 CFLAGS+=	-Wall
 CFLAGS+=	-Wstrict-prototypes -Wmissing-prototypes
@@ -22,6 +23,7 @@ CFLAGS+=	-Wshadow -Wpointer-arith -Wcast
 CFLAGS+=	-Wsign-compare
 
 LDFLAGS+=	-shared
+LDFLAGS+=	-L${LOCALBASE}/lib
 LDLIBS+=	-levent
 
 INSTALL?=	install
