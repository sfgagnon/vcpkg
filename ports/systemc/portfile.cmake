vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(SYSTEMC_VERSION 2.3.4)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/accellera-official/systemc/archive/refs/tags/${SYSTEMC_VERSION}.zip"
    FILENAME "${SYSTEMC_VERSION}.zip"
    SHA512 ec7879a9dd089627a3a232f160ce4e3814faaf393eac3b2f0b01a35d6bf1d43ef95b5baf45b4e040cd6e75d17e3c10e5228832da712d5e5fac51e824253f19ce
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${SYSTEMC_VERSION}
    PATCHES
        install.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMAKE_CXX_STANDARD=17
        -DDISABLE_COPYRIGHT_MESSAGE=ON
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/SystemCLanguage TARGET_PATH share/systemclanguage)
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/SystemCTLM TARGET_PATH share/systemctlm)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/sysc/packages/qt/time)

file(INSTALL ${SOURCE_PATH}/NOTICE DESTINATION ${CURRENT_PACKAGES_DIR}/share/systemc RENAME copyright)
