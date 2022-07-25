# Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY ./*.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out --no-restore

# Run
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80

COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "AspNetCore.dll"]
