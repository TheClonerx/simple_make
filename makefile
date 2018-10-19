CC=gcc
CXX=g++

SRCDIR=src
INCDIR=include
OBJDIR=obj
BINDIR=bin
LIBDIR=lib
TARGET=$(shell basename $(CURDIR))

#general compiler flags
CFLAGS=-Wall -Wextra -std=c11
CPPFLAGS=-Wall -Wextra -std=c++17

#debug compiler flags
CDFLAGS=-g3 -Og -ggdb
CPPDFLAGS=-g3 -Og -ggdb

#release compiler flags
CRFLAGS=-O2 -DNDEBUG
CPPRFLAGS=-O2 -DNDEBUG

#aditional libs
#example: LIB=-ldl -L/path/to/more/libs -lmy_lib
LIB=
#aditional include paths
INC=-I$(INCDIR) -I/usr/local/include

#general linker flags
LINKFLAGS=-L$(LIBDIR) $(LIB)
#debug linker flags
LINKDFLAGS=
#release linker flags
LINKRFLAGS=-s


C_SOURCES=$(shell find $(SRCDIR) -type f -name "*.c")
CPP_SOURCES=$(shell find $(SRCDIR) -type f ! -name "*.c")

CD_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/debug/%.o,$(basename $(C_SOURCES)))
CPPD_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/debug/%.obj,$(basename $(CPP_SOURCES)))

CR_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/release/%.o,$(basename $(C_SOURCES)))
CPPR_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/release/%.obj,$(basename $(CPP_SOURCES)))

release: $(BINDIR)/release/$(TARGET)

debug: $(BINDIR)/debug/$(TARGET)

$(BINDIR)/release/$(TARGET): $(CR_OBJECTS) $(CPPR_OBJECTS)
	@mkdir -pv $(dir $@)
	$(CXX) -o $@ $^ $(LINKFLAGS) $(LINKRFLAGS)

$(BINDIR)/debug/$(TARGET): $(CD_OBJECTS) $(CPPD_OBJECTS)
	@mkdir -pv $(dir $@)
	$(CXX) -o $@ $^ $(LINKFLAGS) $(LINKDLAGS)

$(OBJDIR)/debug/%.o: $(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) -c -o $@ $< $(CFLAGS) $(CDFLAGS) $(INC)

$(OBJDIR)/debug/%.obj: $(SRCDIR)/%.cpp
	@mkdir -pv $(dir $@)
	$(CXX) -c -o $@ $< $(CPPFLAGS) $(CPPDFLAGS) $(INC)

$(OBJDIR)/release/%.o: $(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) -c -o $@ $< $(CFLAGS) $(CRFLAGS) $(INC)

$(OBJDIR)/release/%.obj: $(SRCDIR)/%.cpp
	@mkdir -pv $(dir $@)
	$(CXX) -c -o $@ $< $(CPPFLAGS) $(CPPRFLAGS) $(INC)

clean:
	@rm -rfv $(BINDIR) $(OBJDIR)
