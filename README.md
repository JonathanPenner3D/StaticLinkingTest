This shows an issue with static linking the Swift stdlib with a non-trivial case.

There are two shell scripts to build the files either statically or dynamically linking Foundation (`build_static.sh` and `build_dynamic.sh`, respectively).

Once built, you can go to either build directory and run the test target:
```
./build_static/StaticLinkingTests
```

When running with LLDB attached, it should produce this output:
```
Test Suite 'All tests' started at 2025-04-29 14:33:33.316
Test Suite 'install.xctest' started at 2025-04-29 14:33:33.317
Test Suite 'StaticLinkingTests' started at 2025-04-29 14:33:33.317
Test Case 'StaticLinkingTests.testLibrary' started at 2025-04-29 14:33:33.317
Process 1064117 stopped
* thread #1, name = 'StaticLinkingTe', stop reason = signal SIGSEGV: address not mapped to object (fault address: 0x0)
    frame #0: 0x00007ffff72d83c9 libswiftCore.so`swift::TargetMetadata<swift::InProcess>::getGenericArgs() const + 9
libswiftCore.so`swift::TargetMetadata<swift::InProcess>::getGenericArgs:
->  0x7ffff72d83c9 <+9>:  movq   (%rdi), %rcx
    0x7ffff72d83cc <+12>: xorl   %eax, %eax
    0x7ffff72d83ce <+14>: cmpq   $0x800, %rcx ; imm = 0x800 
    0x7ffff72d83d5 <+21>: cmovael %eax, %ecx
Target 0: (StaticLinkingTests) stopped.
```
