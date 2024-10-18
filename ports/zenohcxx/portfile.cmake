vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO "eclipse-zenoh/zenoh-cpp"
  REF "1.0.0.12"
  HEAD_REF master
  SHA512 "b3427146a74f193e3bbc77a2d05bcad31dd8a4d738fef42fd9a018fc2c8b7e6e982bcb254b9c3834931c2b761f89f2a87145652bfc71623d0cdc875aabe893ba"
)

if (NOT DEFINED ZENOHCXX_ZENOHPICO)
  set(ZENOHCXX_ZENOH_PICO OFF)
endif()

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  DISABLE_PARALLEL_CONFIGURE
  OPTIONS
    -DZENOHCXX_ZENOHPICO=${ZENOHCXX_ZENOHPICO}
    -DZENOHCXX_ZENOHC=ON
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/zenohcxx)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
