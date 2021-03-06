CC=gcc

CFLAGS=-w -m32 -O3 -DNDEBUG

LDFLAGS_ENGINE=-m32 -lm -lGL -lvorbis -lvorbisfile -lz -lSDL2 -lpng -ljpeg -s
LDFLAGS_GAME=-shared -m32 -lm -s

ENGINE_SOURCES=main.c unpak.c unzip.c
GAME_SOURCES=game.c

ENGINE_OBJECTS=$(ENGINE_SOURCES:.c=.o)
GAME_OBJECTS=$(GAME_SOURCES:.c=.o)

ENGINE_EXE=berserkerq2
GAME_LIB=game.so

all: $(ENGINE_EXE) $(GAME_LIB)

$(ENGINE_OBJECTS): %.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(GAME_OBJECTS): %.o : %.c
	$(CC) $(CFLAGS) -fvisibility=hidden -c $< -o $@

$(ENGINE_EXE): $(ENGINE_OBJECTS)
	$(CC) -o $@ $(ENGINE_OBJECTS) $(LDFLAGS_ENGINE)

$(GAME_LIB): $(GAME_OBJECTS)
	$(CC) -o $@ $(GAME_OBJECTS) $(LDFLAGS_GAME)

clean:
	-rm $(ENGINE_EXE) $(GAME_LIB) $(ENGINE_OBJECTS) $(GAME_OBJECTS)
