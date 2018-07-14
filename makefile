CC=gcc
CXX=g++

SRCDIR=src
INCDIR=inc
OBJDIR=obj
BINDIR=bin
TARGET=$(shell basename $(CURDIR))

CFLAGS=-Wall -O3
CPPFLAGS=$(CFLAGS) -std=c++17
LIB=-lpthread -ldl
INC=-I$(INCDIR) -I/usr/local/include

SOURCES=$(shell find $(SRCDIR) -type f)
OBJECTS=$(patsubst $(SRCDIR)/%,$(OBJDIR)/%.o,$(basename $(SOURCES)))

$(BINDIR)/$(TARGET): $(OBJECTS)
	@mkdir -pv $(BINDIR)
	$(CXX) -o $(BINDIR)/$(TARGET) $^ $(LIB)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -pv $(dir $@)
	$(CXX) $(CPPFLAGS) $(INC) -c -o $@ $<

clean:
	@rm -rfv $(BINDIR) $(OBJDIR)
