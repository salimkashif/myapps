FROM mcr.microsoft.com/dotnet/sdk:3.1 as build
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1

WORKDIR /app

EXPOSE 80
EXPOSE 443

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "SuperService.dll"]