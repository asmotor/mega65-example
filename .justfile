# Show help text
@help:
    just -l --unsorted

# Remove all build artifacts
@clean:
    make clean

# Build project
@build:
    make scroll.prg

@run: build
    etherload --run scroll.prg        

