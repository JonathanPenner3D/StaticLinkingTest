mkdir -p build_static && cd build_static;
swiftc -j 64 -num-threads 64 -c -DStaticLinking_EXPORTS -parse-as-library -emit-module -emit-module-path StaticLinking.swiftmodule -module-name StaticLinking -module-link-name StaticLinking -static-stdlib -Xlinker -static-stdlib ../StaticLinking.swift && \
swiftc -j 64 -num-threads 64 -emit-library -static-stdlib -Xlinker '-rpath=$ORIGIN' -ldl -lpthread -lswiftCore -ldispatch -lBlocksRuntime -lstdc++ -lm -Xlinker -export-dynamic -Xlinker --exclude-libs -Xlinker ALL  -Xlinker -soname -Xlinker libStaticLinking.so -o libStaticLinking.so StaticLinking.o && \
swiftc -j 64 -num-threads 64 -c  -module-name StaticLinkingTests -I $PWD ../main.swift && \
swiftc -j 64 -num-threads 64 -emit-executable -o StaticLinkingTests  main.o  -L $PWD -Xlinker -rpath -Xlinker $PWD;

