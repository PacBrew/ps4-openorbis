cmake_minimum_required(VERSION 3.0)

###################################################################

if (NOT DEFINED ENV{OPENORBIS})
    set(OPENORBIS /opt/pacbrew/ps4/openorbis)
else ()
    set(OPENORBIS $ENV{OPENORBIS})
endif ()

if (NOT DEFINED ENV{OO_PS4_TOOLCHAIN})
    set(OO_PS4_TOOLCHAIN /opt/pacbrew/ps4/openorbis)
else ()
    set(OO_PS4_TOOLCHAIN $ENV{OO_PS4_TOOLCHAIN})
endif ()

list(APPEND CMAKE_MODULE_PATH "${OPENORBIS}/cmake")

set(PS4 TRUE)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(TARGET x86_64-pc-freebsd-elf)
set(CMAKE_SYSTEM_VERSION 12)
set(CMAKE_CROSSCOMPILING 1)

set(CMAKE_ASM_COMPILER ${OPENORBIS}/bin/clang CACHE PATH "")
set(CMAKE_C_COMPILER ${OPENORBIS}/bin/clang CACHE PATH "")
set(CMAKE_CXX_COMPILER ${OPENORBIS}/bin/clang++ CACHE PATH "")
set(CMAKE_LINKER ${OPENORBIS}/bin/ld.lld CACHE PATH "")
set(CMAKE_AR ${OPENORBIS}/bin/llvm-ar CACHE PATH "")
set(CMAKE_RANLIB ${OPENORBIS}/bin/llvm-ranlib CACHE PATH "")
set(CMAKE_STRIP ${OPENORBIS}/bin/llvm-strip CACHE PATH "")

set(CMAKE_LIBRARY_ARCHITECTURE x86_64 CACHE INTERNAL "abi")

set(CMAKE_FIND_ROOT_PATH ${OPENORBIS} ${OPENORBIS}/usr)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "Shared libs not available")

###################################################################

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(PS4_COMMON_INCLUDES "-isysroot ${OPENORBIS} -isystem ${OPENORBIS}/include -I${OPENORBIS}/usr/include")
set(PS4_COMMON_FLAGS "--target=x86_64-pc-freebsd12-elf -D__PS4__ -D__OPENORBIS__ -D__ORBIS__ -fPIC -funwind-tables ${PS4_COMMON_INCLUDES}")
set(PS4_COMMON_LIBS "-L${OPENORBIS}/lib -L${OPENORBIS}/usr/lib -lc -lkernel")

set(CMAKE_C_FLAGS_INIT "${PS4_COMMON_FLAGS}")
set(CMAKE_CXX_FLAGS_INIT "${PS4_COMMON_FLAGS} -I${OPENORBIS}/include/c++/v1")
set(CMAKE_ASM_FLAGS_INIT "${PS4_COMMON_FLAGS}")

set(PS4_LINKER_FLAGS "-m elf_x86_64 -pie --eh-frame-hdr --script ${OPENORBIS}/link.x ${OPENORBIS}/lib/crt1.o")
# crt1.o may be already added to LDFLAGS from "ps4vars.sh", so remove LDFLAGS env (todo: find a better way...)
set(ENV{LDFLAGS} "" CACHE STRING FORCE)

set(CMAKE_EXE_LINKER_FLAGS_INIT "${PS4_LINKER_FLAGS} ${PS4_COMMON_LIBS}")
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> -o <TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES>") # <FLAGS>
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_LINKER> -o <TARGET> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  <LINK_LIBRARIES>") # <FLAGS>

# Start find_package in config mode
set(CMAKE_FIND_PACKAGE_PREFER_CONFIG TRUE)

# Set pkg-config for the same
find_program(PKG_CONFIG_EXECUTABLE NAMES openorbis-pkg-config HINTS "${OPENORBIS}/usr/bin")
if (NOT PKG_CONFIG_EXECUTABLE)
    message(WARNING "Could not find openorbis-pkg-config: try installing ps4-openorbis-pkg-config")
endif ()

function(add_self project)
     set(AUTH_INFO "000000000000000000000000001C004000FF000000000080000000000000000000000000000000000000008000400040000000000000008000000000000000080040FFFF000000F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    add_custom_command(
            OUTPUT "${project}.self"
            COMMAND ${CMAKE_COMMAND} -E env "OO_PS4_TOOLCHAIN=${OPENORBIS}" "${OPENORBIS}/bin/create-fself" "-in=${project}" "-out=${project}.oelf" "--eboot" "eboot.bin" "--paid" "0x3800000000000011" "--authinfo" "${AUTH_INFO}"
            VERBATIM
            DEPENDS "${project}"
    )
    add_custom_target(
            "${project}_self" ALL
            DEPENDS "${project}.self"
    )
endfunction()

function(add_pkg project title-id title version)
    add_custom_command(
            OUTPUT "${project}.pkg"
            # copy required files to binary directory
            COMMAND cp -rf ${CMAKE_SOURCE_DIR}/sce_sys .
            COMMAND cp -rf ${CMAKE_SOURCE_DIR}/sce_module .
            # generate sfo
            COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_new sce_sys/param.sfo
            COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo APP_TYPE --type Integer --maxsize 4 --value 1
            COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo APP_VER --type Utf8 --maxsize 8 --value "${version}"
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo ATTRIBUTE --type Integer --maxsize 4 --value 0
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo CATEGORY --type Utf8 --maxsize 4 --value "gd"
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo CONTENT_ID --type Utf8 --maxsize 48 --value "IV0001-${title-id}_00-${title-id}0000000"
            COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo DOWNLOAD_DATA_SIZE --type Integer --maxsize 4 --value 0
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo SYSTEM_VER --type Integer --maxsize 4 --value 0
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo TITLE --type Utf8 --maxsize 128 --value "${title}"
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo TITLE_ID --type Utf8 --maxsize 12 --value "${title-id}"
	          COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" sfo_setentry sce_sys/param.sfo VERSION --type Utf8 --maxsize 8 --value "${version}"
            # generate gp4 file
            COMMAND "${OPENORBIS}/bin/linux/create-gp4" -out pkg.gp4 --content-id "IV0001-${title-id}_00-${title-id}0000000" --files "eboot.bin sce_sys/about/right.sprx sce_sys/param.sfo sce_sys/icon0.png sce_module/libc.prx sce_module/libSceFios2.prx"
            # generate pkg
            COMMAND "${OPENORBIS}/bin/linux/PkgTool.Core" pkg_build pkg.gp4 .
            VERBATIM
            DEPENDS "${project}.self"
    )
    add_custom_target(
            "${project}_pkg" ALL
            DEPENDS "${project}.pkg"
    )
endfunction()
