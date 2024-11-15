# CXX = g++
CFLAGS = -I/opt/homebrew/opt/llvm/includ -I/opt/homebrew/opt/libomp/include -std=c++11 -Wall -O3 -Xclang -fopenmp

BIN = ./bin/segphrase_train ./bin/segphrase_segment
.PHONY: clean all

all: ./bin $(BIN)

./bin/segphrase_train: ./src/main.cpp ./src/utils/*.h ./src/frequent_pattern_mining/*.h ./src/data/*.h ./src/classification/*.h ./src/model_training/*.h ./src/clustering/*.h
./bin/segphrase_segment: ./src/segment.cpp ./src/utils/*.h ./src/frequent_pattern_mining/*.h ./src/data/*.h ./src/classification/*.h ./src/model_training/*.h ./src/clustering/*.h

./bin:
	mkdir -p bin

LDFLAGS= -L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/opt/libomp/lib -lomp -pthread -lm -Wno-unused-result -Wno-sign-compare -Wno-unused-variable -Wno-parentheses -Wno-format
$(BIN) :
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ $(filter %.cpp %.o %.c, $^)
$(OBJ) :
	$(CXX) -c $(CFLAGS) -o $@ $(firstword $(filter %.cpp %.c, $^) )

clean :
	rm -rf bin
