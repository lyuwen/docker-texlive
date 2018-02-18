# A LaTeX Docker image

A docker image contains a custome installation of texlive.

## TeX

TeX is installed using the script in [lyuwen/install-tl-ubuntu](https://github.com/lyuwen/install-tl-ubuntu),
a fork of original [*scottkosty/install-tl-ubuntu*](https://github.com/scottkosty/install-tl-ubuntu) where I added
the ability to choose installation scheme.

## Usage

Obtain the docker image

```bash
sudo docker pull fulvwen/texlive
```

Let's say you want to compile the file main.tex under you current work path.

```bash
sudo docker run -ti -v ${PWD}:/workspace fulvwen/texlive pdflatex main.tex
```

The container also support scons.

```bash
sudo docker run -ti -v ${PWD}:/workspace fulvwen/texlive  scons
```

The container has the custome installation scheme in addition including tikz and standalone packages.

## Build the docker on your own

```bash
sudo docker build -t texlive .
```
