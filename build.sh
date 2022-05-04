#!/bin/sh
mkdir -p Debug
cat *.lua > Debug/dest.lua # unsure if order matters
wine Luna/luna.exe Debug/dest.lua Debug/Expansion.tns
