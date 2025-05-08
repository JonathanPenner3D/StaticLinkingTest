mkdir -p build_dynamic && cd build_dynamic;
swiftc -j 64 -num-threads 64 -c -DStaticLinking_EXPORTS -parse-as-library -emit-module -emit-module-path StaticLinking.swiftmodule -module-name StaticLinking -module-link-name StaticLinking ../StaticLinking.swift && \
swiftc -j 64 -num-threads 64 -emit-library -Xlinker -soname -Xlinker libStaticLinking.so -o libStaticLinking.so StaticLinking.o && \
swiftc -j 64 -num-threads 64 -c  -module-name StaticLinkingTests -I ./ ../main.swift && \
swiftc -j 64 -num-threads 64 -emit-executable -o StaticLinkingTests  main.o  -L ./ -Xlinker -rpath -Xlinker ./;

