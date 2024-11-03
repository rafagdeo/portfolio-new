#!/bin/bash

# Instalar dependências Elixir
mix deps.get

# Instalar dependências de JavaScript (dentro da pasta assets)
npm install --prefix assets

# Compilar assets e gerar arquivos estáticos
npm run deploy --prefix assets
mix phx.digest

# Compilar o projeto Phoenix
MIX_ENV=prod mix compile
