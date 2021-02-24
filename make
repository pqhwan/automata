#!/bin/bash

[[ "$1" == 'build' ]] && {
    echo building..
    GOOS=js GOARCH=wasm go build -o main.wasm
    cp main.wasm static/
    cd rust-wasm
    wasm-pack build --release --target web
    cd ..
    cp -r rust-wasm/pkg static/
    go build
}

[[ "$1" == 'clean' ]] && {
    echo cleaning..
    [[ -f "static/main.wasm" ]] && rm -f static/main.wasm
    [[ -d "static/pkg" ]] && {
        rm -f static/pkg/*
        rm -f static/pkg/.gitignore
        rmdir static/pkg
    }
    [[ -d "rust-wasm/pkg" ]] && {
        rm -f rust-wasm/pkg/*
        rm -f rust-wasm/pkg/.gitignore 
        rmdir rust-wasm/pkg
    }
    go clean
    rm main.wasm
}
