CC = g++
CFLAGS = -Wall -g
SRC = main.cpp funca.cpp
OBJ = $(SRC:.cpp=.o)
TARGET = program

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJ) $(TARGET)

