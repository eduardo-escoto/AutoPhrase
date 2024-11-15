export CC=/opt/homebrew/opt/llvm/bin/clang
export CXX="$CC++"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/libomp/include"

if [ "$(uname)" == "Darwin" ]; then
    make all CXX=$CXX | grep -v "Nothing to be done for"
    cp tools/treetagger/bin/tree-tagger-mac tools/treetagger/bin/tree-tagger
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    make all CXX=g++ | grep -v "Nothing to be done for"
    if [[ $(uname -r) == 2.6* ]]; then
        cp tools/treetagger/bin/tree-tagger-linux-old tools/treetagger/bin/tree-tagger
    else
        cp tools/treetagger/bin/tree-tagger-linux tools/treetagger/bin/tree-tagger
    fi
fi
#if [ ! -e tools/tokenizer/build/Tokenizer.class ]; then
mkdir -p tools/tokenizer/build/
javac -cp ".:tools/tokenizer/lib/*" tools/tokenizer/src/Tokenizer.java -d tools/tokenizer/build/
#fi
