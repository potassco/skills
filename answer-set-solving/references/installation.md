# Installation

This skill works best when `python3 -m clingo` is available in the active environment. The optional helpers also use `ngo` and `clorm`.

## Check What Is Already Installed

```bash
python3 -m clingo --version
python3 -c 'import clingo; print(clingo.__version__)'
python3 -c 'import ngo; print(ngo.__file__)'
python3 -c 'import clorm; print(clorm.__version__)'
```

If one of the imports fails, install the missing package in the environment you actually plan to use for the skill scripts.

## clingo

The official clingo page lists several install routes. Pick the one that matches how you manage environments.

### pip

This is the most direct route when you want the Python module and `python3 -m clingo` in a virtual environment or user install.

```bash
python3 -m pip install --upgrade clingo
```

### conda

The clingo site recommends conda-forge for Python-enabled packages.

```bash
conda create -n potassco -c conda-forge clingo
conda activate potassco
```

The clingo page also mentions additional packages in the `potassco` channel.

### Linux and OS package managers

The clingo site points to these package sources:

- Debian packages
- Ubuntu PPA from Potassco
- Arch Linux AUR
- FreeBSD via FreshPorts
- Homebrew on macOS
- MacPorts on macOS
- Spack for HPC-style environments

Use these when they match your system management model, but verify that the resulting install includes the Python module if you need `python3 -m clingo`.

### Releases or source

If you need a specific upstream build, use the official releases or source repository:

- Releases: <https://github.com/potassco/clingo/releases>
- Source: <https://github.com/potassco/clingo>

This is also the right path when you need a custom build or are dealing with older legacy encodings.

## ngo

Install ngo from PyPI in the same Python environment as clingo:

```bash
python3 -m pip install --upgrade ngo
```

After installation, verify that Python can import it:

```bash
python3 -c 'import ngo; print(ngo.__file__)'
```

## clorm

The Clorm installation docs list four main routes and require Python 3.9+ with Clingo 5.6+.

### pip

```bash
python3 -m pip install --upgrade clorm
```

### conda

The Clorm docs say to install clingo first, then clorm from the `potassco` channel:

```bash
conda install -c potassco clingo
conda install -c potassco clorm
```

### Ubuntu PPA

The Clorm docs recommend the Potassco PPA for Ubuntu users:

```bash
sudo add-apt-repository ppa:potassco/stable
sudo apt-get update
sudo apt install python3-clorm
```

The same docs warn that the standard Ubuntu clingo packages do not correctly provide the Python module, even if the executable itself is present.

### source

```bash
git clone https://github.com/potassco/clorm
cd clorm
python3 -m pip install .
```

The Clorm docs note that source installation assumes clingo with Python support is already installed.

## Recommended Minimal Setup For This Skill

If you are using a Python virtual environment for this repository, the smallest working setup is usually:

```bash
python3 -m pip install --upgrade clingo ngo clorm
```

Then re-run the version and import checks at the top of this file.

## Sources

- clingo install page: <https://potassco.org/clingo/>
- Clorm installation docs: <https://clorm.readthedocs.io/en/latest/clorm/installation.html>