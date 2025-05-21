# Greg Thomsen's Dotfiles
This collection of configuration files has been refined to support scientific
computing (C/MATLAB/Fortran/Python) on Linux systems, usually without graphical
interfaces.  Development is centered around per-project `screen` sessions
hosting an instance of Emacs that drives development, debugging, and testing for
it.

# Highlights
There are a couple of things worth mentioning in this collection of
configuration files:

* An emphasis on driving everything from the keyboard.  Graphical tools are used
  when they're better than text-based alternatives, though aren't the default
  approach.

* Having consistently setup, self-contained `screen` instances.  Almost all
  project work starts with:

  ```shell
     $ screen code project-name
  ```

  An Emacs instance is started with a unique server name (`project-name`) and
  the environment is configured so all editing goes through it.  This allows
  multiple projects to be worked on concurrently, without co-mingling files and
  buffers.

* XTerms are configured with 8-bit color when available.  This provides a wider
  range of colors for Emacs to work with.

* Split shell configuration making intent clear by the fragment's name/contents.
  This is easy to adapt into existing shell configurations (sourcing the
  bootstrap piece) or dropping in wholesale.

* `screen` is configured with a prefix key of `C-j` instead of the normal `C-a`
  to spare my poor pinky when working in the shell and Emacs.

# Installation
A simple installation script, `install-as-symlinks.sh`, is available which
backs up existing configurations and creates symbolic links to the files in
this repository.  This enables easy updates as any changes made will visible
to Git without additional effort.

## Cloning the Repository
Since this repository includes other repositories as submodules, you'll need to
either 1) recursively clone this repository or 2) fetch each of the submodules
individually.

Recursive cloning is available for those who have setup SSH keys with their
Github account via:

```shell
  $ git clone --recursive git@github.com:gthomsen/dotfiles.git
```

While fetching each submodule can be done like so:

```shell
  $ git clone https://github.com/gthomsen/dotfiles.git
  $ cd dotfiles
  $ git config -f .gitmodules submodule.".emacs.d/elisp/align-f90".url \
                  https://github.com/gthomsen/align-f90.git
  $ git config -f .gitmodules submodule.".emacs.d/elisp/align-matlab".url \
                  https://github.com/gthomsen/align-matlab.git
  $ for MODULE in align-f90 align-matlab matlab; do \
       git submodule update --init .emacs.d/elisp/${MODULE}; \
    done
```

## Install Via Symbolic Links
Change into the repository's working directory and run `install-as-symlinks.sh`.
Existing configurations will be moved into
`${HOME}/.user-configuration-backups/` and new symbolic links will be made to
the working copy's contents.

## Install External Software
Several Emacs packages require external commands to function properly.  Below
are a list of external packages that should be installed for each Emacs package:

### `Markdown-mode`

* [Pandoc](http://pandoc.org/) is needed to render Markdown files into HTML for
  previews.  Optional if the mode is only used for syntax highlighting.

## Post-Installation Setup
Some setup is required before development can be done with this user
configuration.  See below for details.

### Git
The default `user.name` and `user.email` in the provided `.gitconfig are
hardcoded for the repository owner's convenience.  Please change them
prior to making commits so changes are not attributed to them!

``` shell
$ git config --global user.name "John Doe"
$ git config --global user.email "john.doe@domain.com"
```

### Emacs
The following packages are optional and can be installed for additional
functionality:

- [dockerfile-mode](https://melpa.org/#/dockerfile-mode) Mode for editing
  Dockerfile files
- [eglot](https://elpa.gnu.org/packages/eglot.html) Language Server Protocol
  (LSP) mode that interfaces with language-specific servers
- [gptel](https://melpa.org/#/gptel) Chat interface to large language models
  (LLMs)
- [Magit](https://melpa.org/#/magit) Working with Git repositories
- [markdown-mode](https://melpa.org/#/markdown-mode) Mode for editing Markdown files
- [rmsbolt](https://melpa.org/#/rmsbolt) Local version of [Compiler Explorer](https://godbolt.org/)
- [tramp](https://elpa.gnu.org/packages/tramp.html) Work with remote files
  (e.g. via SSH on remote servers, in containers, etc) as if they were local

To install all of the optional packages, launch Emacs and run the following
Lisp (`M-x :` and then paste the following):

```lisp
(progn
  (package-refresh-contents)
  (package-install 'dockerfile-mode)
  (package-install 'eglot)
  (package-install 'gptel)
  (package-install 'magit)
  (package-install 'markdown-mode)
  (package-install 'rmsbolt)
  (package-install 'tramp))
```

#### Language Server Installation
Eglot is a language-independent language server interface and requires external
language-specific servers to perform the heavy lifting.  This configuration file
enables Eglot when editing Fortran and Python code, but only when the
corresponding language servers are present so as to avoid spurious warnings
like:

```
Warning (eglot): Searching for program: No such file or directory, fortls
```

##### Fortran
[`fortls`](https://github.com/fortran-lang/fortls) is the preferred Fortran
language server.  This is forked from the original Fortran Language Server and
provides active development and additional functionality and bug fixes.

If one has Python installation provided by Anaconda, `fortls` can be installed
from Conda Forge like so:

``` shell
$ conda install -c conda-forge fortls
```

##### Python
Many Python language servers are available and supported by Eglot though the
[Python LSP Server](https://github.com/python-lsp/python-lsp-server) is
preferred for the number of optional dependencies it supports
(e.g. [`pycodestyle`](https://github.com/PyCQA/pycodestyle),
[`Pyflakes`](https://github.com/PyCQA/pyflakes),
[`pylsp-mypy`](https://github.com/Richardk2n/pylsp-mypy), etc).

Conveniently, it is included with a stock Anaconda Python distribution meaning
that only dependencies are required to be installed.  The following enables
type checking support via [MyPy](https://github.com/python/mypy) as well as
faster linting via [Ruff](https://docs.astral.sh/ruff/).

``` shell
$ conda install mypy pyslp-mypy ruff
```
