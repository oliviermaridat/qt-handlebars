include(handlebars/Handlebars.pri)

include($$PWD/../vendor/qompote.pri)
$$setLibPath()

VENDORNAME=mdhooge
APPNAME=Handlebars
TARGET = $$getLibName($$APPNAME, "Qt")
TEMPLATE = lib
CONFIG += staticlib
CONFIG += debug_and_release build_all
CONFIG *= c++11
VERSION = 1.0.1

defined(EXPORT_PATH_PREFIX, "var"){
    EXPORT_PATH = $$EXPORT_PATH_PREFIX
}
else{
    EXPORT_PATH = $$OUT_PWD/../export
}
EXPORT_PATH = $${EXPORT_PATH}/$${VENDORNAME}/$${APPNAME}/v$${VERSION}-lib
EXPORT_INCLUDEPATH = $$EXPORT_PATH/include
EXPORT_LIBPATH = $$EXPORT_PATH/$$LIBPATH
message($${APPNAME} [ export folder is $${EXPORT_PATH} ])

# Lib
QMAKE_STRIP = echo # Avoid striping header files (which will not work)
DESTDIR = $${EXPORT_LIBPATH}

# Include files
headers.files = $$PUBLIC_HEADERS
headers.path = $$EXPORT_INCLUDEPATH
INSTALLS += headers

## qompoter.pri
qompoter.files = $$PWD/../qompoter.pri
qompoter.files += $$PWD/../qompoter.json
qompoter.path = $$EXPORT_PATH
INSTALLS += qompoter



#CONFIG(release, debug|release) {
#  TARGET      = Handlebars
#  MOC_DIR     = ../build/release
#  OBJECTS_DIR = ../build/release
#  UI_DIR      = ../build/release
#}
#else {
#  TARGET      = Handlebarsd
#  MOC_DIR     = ../build/debug
#  OBJECTS_DIR = ../build/debug
#  UI_DIR      = ../build/debug
#}
