FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN dotnet tool install --global cosmicworks

RUN dotnet dev-certs https

RUN dotnet workload update

RUN dotnet workload install wasm-tools