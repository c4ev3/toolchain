# -*-makefile-*-

#
# just quote removal
#
PTXCONF_TOOLCHAIN_CONFIG_SYSROOT		:= $(call remove_quotes, $(PTXCONF_TOOLCHAIN_CONFIG_SYSROOT))
PTXCONF_TOOLCHAIN_CONFIG_MULTILIB		:= $(call remove_quotes, $(PTXCONF_TOOLCHAIN_CONFIG_MULTILIB))

PTXCONF_GLIBC_HEADERS_FAKE_CROSS		:= $(call remove_quotes, $(PTXCONF_GLIBC_HEADERS_FAKE_CROSS))
PTXCONF_GLIBC_CONFIG_EXTRA			:= $(call remove_quotes, $(PTXCONF_GLIBC_CONFIG_EXTRA))
PTXCONF_GLIBC_CONFIG_EXTRA_CROSS		:= $(call remove_quotes, $(PTXCONF_GLIBC_CONFIG_EXTRA_CROSS))

PTXCONF_CROSS_GCC_CONFIG_EXTRA			:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_EXTRA))
PTXCONF_CROSS_GCC_CONFIG_LIBC			:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_LIBC))
PTXCONF_CROSS_GCC_CONFIG_CXA_ATEXIT		:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_CXA_ATEXIT))
PTXCONF_CROSS_GCC_CONFIG_SJLJ_EXCEPTIONS	:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_SJLJ_EXCEPTIONS))
PTXCONF_CROSS_GCC_CONFIG_LIBSSP			:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_LIBSSP))
PTXCONF_CROSS_GCC_CONFIG_SHARED			:= $(call remove_quotes, $(PTXCONF_CROSS_GCC_CONFIG_SHARED))

PTXCONF_ARCH					:= $(call remove_quotes, $(PTXCONF_ARCH))

#
# namespace cleanup
#
PTX_TOUPLE_TARGET				:= $(PTXCONF_GNU_TARGET)

PTX_HOST_CROSS_AUTOCONF_HOST			:= --host=$(GNU_HOST)
PTX_HOST_CROSS_AUTOCONF_BUILD			:= --build=$(GNU_HOST)
PTX_HOST_CROSS_AUTOCONF_TARGET			:= --target=$(PTX_TOUPLE_TARGET)

PTX_HOST_AUTOCONF_PREFIX			:= --prefix=$(PTXCONF_SYSROOT_HOST)
PTX_HOST_CROSS_AUTOCONF_PREFIX			:= --prefix=$(PTXCONF_SYSROOT_CROSS)

PTX_HOST_AUTOCONF := \
	$(PTX_HOST_AUTOCONF_HOST) \
	$(PTX_HOST_AUTOCONF_PREFIX)

PTX_HOST_CROSS_AUTOCONF := \
	$(PTX_HOST_CROSS_AUTOCONF_BUILD) \
	$(PTX_HOST_CROSS_AUTOCONF_HOST) \
	$(PTX_HOST_CROSS_AUTOCONF_TARGET) \
	$(PTX_HOST_CROSS_AUTOCONF_PREFIX)

#
# overwrite to remove rpath
#
PTXDIST_HOST_LDFLAGS				:= -L${PTXDIST_PATH_SYSROOT_HOST_PREFIX}/lib

#
# gcc-first
#
CROSS_GCC_FIRST_PREFIX	:= $(PTXCONF_SYSROOT_CROSS)/gcc-first
CROSS_PATH		:= $(PTXCONF_SYSROOT_CROSS)/bin:$(PTXCONF_SYSROOT_CROSS)/sbin:$(CROSS_GCC_FIRST_PREFIX)/bin:$$PATH

#
# debuggable gcc/glibc
#
ifdef PTXCONF_TOOLCHAIN_DEBUG
BUILDDIR_DEBUG		:= $(PTXCONF_SYSROOT_CROSS)/src/target
BUILDDIR_CROSS_DEBUG	:= $(PTXCONF_SYSROOT_CROSS)/src/cross
else
BUILDDIR_DEBUG		:= $(BUILDDIR)
BUILDDIR_CROSS_DEBUG	:= $(CROSS_BUILDDIR)
endif

#
# images
#

PTX_TOOLCHAIN_HOST_ARCH	:= $(shell uname -m)
ifeq ($(PTX_TOOLCHAIN_HOST_ARCH),x86_64)
PTX_TOOLCHAIN_HOST_ARCH	:= amd64
endif
ifeq ($(patsubst i%86,,$(PTX_TOOLCHAIN_HOST_ARCH)),)
PTX_TOOLCHAIN_HOST_ARCH	:= i386
endif
ifeq ($(PTX_TOOLCHAIN_HOST_ARCH),ppc)
PTX_TOOLCHAIN_HOST_ARCH	:= powerpc
endif

# vim: syntax=make
