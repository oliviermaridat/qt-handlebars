qt-handlebars-lib {
    DEFINES += QOMP_QTHANDLEBARS

    LIBNAME = Handlebars
    IMPORT_INCLUDEPATH = $$PWD/$$LIBNAME/include
    IMPORT_LIBPATH = $$PWD/$$LIBPATH
    INCLUDEPATH += $$IMPORT_INCLUDEPATH
    LIBS += -L$$IMPORT_LIBPATH -l$$getLibName($${LIBNAME}, "Qt")
}

qt-handlebars {
    DEFINES += QOMP_QTHANDLEBARS

    SOURCES += \
        $$PWD/handlebars/HandlebarsFlex.cpp \
        $$PWD/handlebars/HandlebarsIStreamManager.cpp \
        $$PWD/handlebars/HandlebarsNodes.cpp \
        $$PWD/handlebars/HandlebarsParser.cpp \
        $$PWD/handlebars/HandlebarsParsingContext.cpp \
        $$PWD/handlebars/HandlebarsRenderingContext.cpp \

    HEADERS += \
        $$PWD/handlebars/HandlebarsFlex.h \
        $$PWD/handlebars/HandlebarsHelpers.h \
        $$PWD/handlebars/HandlebarsIStreamManager.h \
        $$PWD/handlebars/HandlebarsNodes.h \
        $$PWD/handlebars/HandlebarsParser.h \
        $$PWD/handlebars/HandlebarsParsingContext.h \
        $$PWD/handlebars/HandlebarsRenderingContext.h \

    FLEXSOURCE = $$PWD/handlebars/Handlebars.l
    BISONSOURCE = $$PWD/handlebars/Handlebars.y
    
    flex.name = Flex ${QMAKE_FILE_IN}
    flex.input = FLEXSOURCE
    flex.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.l.cc
    flex.commands = flex -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.l.cc ${QMAKE_FILE_IN}
    flex.CONFIG += target_predeps
    flex.variable_out = GENERATED_SOURCES
    silent:flex.commands = @echo Lex ${QMAKE_FILE_IN} && $$flex.commands
    QMAKE_EXTRA_COMPILERS += flex

    OTHER_FILES += \
        $$FLEXSOURCE

    bison.name = Bison ${QMAKE_FILE_IN}
    bison.input = BISONSOURCE
    bison.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.y.cc
    bison.commands = bison -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.y.cc ${QMAKE_FILE_IN}
    bison.CONFIG += target_predeps
    bison.variable_out = GENERATED_SOURCES
    silent:bison.commands = @echo Bison ${QMAKE_FILE_IN} && $$bison.commands
    QMAKE_EXTRA_COMPILERS += bison

    bison_h.name = Bison Header ${QMAKE_FILE_IN}
    bison_h.input = BISONSOURCE
    bison_h.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.y.hh
    bison_h.commands = bison -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.y.cc ${QMAKE_FILE_IN}
    bison_h.CONFIG += target_predeps no_link
    silent:bison_h.commands = @echo Bison Header ${QMAKE_FILE_IN} && $$bison.commands
    QMAKE_EXTRA_COMPILERS += bison_h

    OTHER_FILES += \
        $$BISONSOURCE
}
