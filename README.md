# .Net Core GitVersion on Docker Container

## GitVersion Dockerfile for Semantic Versioning

[![Docker Pulls](https://img.shields.io/docker/pulls/elioseverojunior/docker-dotnet-gitversion.svg)](https://hub.docker.com/r/elioseverojunior/gitversion/) [![Docker Automated build](https://img.shields.io/docker/automated/elioseverojunior/gitversion.svg)](https://hub.docker.com/r/elioseverojunior/docker-dotnet-gitversion/) [![Docker Build Status](https://img.shields.io/docker/build/elioseverojunior/gitversion.svg)](https://hub.docker.com/r/elioseverojunior/gitversion/)

## This Image Using

|                                  | Name          | Version       |
| --------------------------------- |:-------------:| -------------:|
| OS                               | Debian        | Bullseye (11) |
| .NET SDK                         | .NET SDK      | 6.0 (6.0.400) |
| Git Version   (DotNet Core Tool) | CLI           |        5.10.3 |

Please check [Releases Page](https://github.com/elioseverojunior/gitversion/releases) for details.

## Latest Versions

[Latest Debian](https://www.debian.org/releases/stable/)
[Latest .Net SDK](https://www.microsoft.com/net/download/all)
[Latest Git Version](https://www.nuget.org/packages/dotnet-gitversion)

## Configuration Sample

```yaml
assembly-versioning-format: '{Major}.{Minor}.{Patch}.{CommitsSinceVersionSource}'
mode: Mainline
merge-message-formats: {}
branches:
  main:
    regex: main
    mode: ContinuousDelivery
    tag: ''
    increment: None
  master:
    regex: master
    mode: ContinuousDelivery
    tag: ''
    increment: None
  develop:
    regex: develop$
    mode: ContinuousDelivery
    tag: dev
    increment: None
    is-source-branch-for: ['feature', 'feat', 'hotfix']
    tracks-release-branches: false
    prevent-increment-of-merged-branch-version: true
  release:
    regex: release[s]?[/-]
    mode: ContinuousDelivery
    tag: release
    increment: None
  feature:
    regex: (feature[s]?[/-]|feat?[/-])
    mode: ContinuousDelivery
    tag: useBranchName
    increment: None
  pull-request:
    regex: (pull|pull\-request[s]|pr)[/-]
    mode: ContinuousDelivery
    tag: PullRequest
    increment: Inherit
    prevent-increment-of-merged-branch-version: true
    tag-number-pattern: '[/-](?<number>\d+)[-/]'
  hotfix:
    regex: bugfix(es)?[/-]
    mode: ContinuousDelivery
    tag: useBranchName
    increment: None
    prevent-increment-of-merged-branch-version: true
```

## Docker Sample

```Dockerfile
FROM elioseverojunior/gitversion:latest

LABEL maintainer="Elio Severo Junior"
LABEL contact="elioseverojunior@gmail.com"
LABEL description="Docker DotNet GitVersion"

ENV BRANCH_NAME=""

COPY setversion.sh /bin/setversion

WORKDIR /pre-build

COPY . .

RUN ls -lha

ENTRYPOINT [ "/bin/setversion" ]
```

## Using Example

And then you need .Net Core project. If you haven't one, run this codes;

```bash
mkdir ConsoleApplication1
cd ConsoleApplication1

dotnet new console
dotnet new sln
dotnet sln ConsoleApplication1.sln add ConsoleApplication1.csproj
git init
```

Take login token from sonarqube server, change working directory to project directory and run this code;

```bash
docker run --name dotnet-gitversion -it --rm -v $(pwd):/pre-build \
  elioseverojunior/docker-dotnet-gitversion
```

## Maintainer

<elioseverojunior@gmail.com>
