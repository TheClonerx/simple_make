CC=gcc
CXX=g++

SRCDIR=src
INCDIR=inc
OBJDIR=obj
BINDIR=bin
TARGET=$(shell basename $(CURDIR))

CFLAGS=-Wall -g
CPPFLAGS=$(CFLAGS) -std=c++17
LIB=-lpthread -ldl -lsfml-system -lsfml-network
INC=-I$(INCDIR) -I/usr/local/include

C_SOURCES=$(shell find $(SRCDIR) -type f -name "*.c")
CPP_SOURCES=$(shell find $(SRCDIR) -type f ! -name "*.c")

C_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/%.o,$(basename $(C_SOURCES)))
CPP_OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/%.obj,$(basename $(CPP_SOURCES)))

$(BINDIR)/$(TARGET): $(C_OBJECTS) $(CPP_OBJECTS)
	@mkdir -pv $(BINDIR)
	$(CXX) -Wl,-export-dynamic -o $(BINDIR)/$(TARGET) $^ $(LIB)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/%.obj: $(SRCDIR)/%.cpp
	@mkdir -pv $(dir $@)
	$(CXX) $(CPPFLAGS) $(INC) -c -o $@ $<

clean:
	@rm -rfv $(BINDIR) $(OBJDIR)
