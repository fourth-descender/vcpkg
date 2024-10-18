vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO "eclipse-zenoh/zenoh-c"
  REF "1.0.0.12"
  HEAD_REF master
  SHA512 "ce3de5f1c7cfe33841d117768a931d325ad4868b7731bad2c4a6da6728791f9d926e5938f97cf7696fd5748a7617acceaadefb21bf214570d9d77a1ddb0df3df"
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  set(BUILD_SHARED_LIBS FALSE)
else()
  set(BUILD_SHARED_LIBS TRUE)
endif()

if(VCPKG_TARGET_IS_WINDOWS)
  set(CARGO_BIN_DIR "$ENV{USERPROFILE}\\.cargo\\bin")
else()
  set(CARGO_BIN_DIR "$ENV{HOME}/.cargo/bin")
endif()
set(ENV{PATH} "$ENV{PATH};${CARGO_BIN_DIR}")

find_program(CARGO_FOUND NAMES cargo)
if(NOT CARGO_FOUND)
  message(FATAL_ERROR
    "Cargo executable not found. Please ensure Cargo is installed and available in ~/.cargo/bin.\n"
    "You can install Cargo from https://rustup.rs/.\n"
  )
endif()

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  DISABLE_PARALLEL_CONFIGURE
  OPTIONS
    -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/zenohc)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
