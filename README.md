<p align="center">
  <a href="https://twitter.com/codefordao"><img src="https://avatars.githubusercontent.com/u/97301607?s=200&u=d0a9f88d13d7d7dd5b37c09fdd802c9fe378d029&v=4"/></a>
</p>
<h2 align="center">
  CodeforDAO Contracts in Cairo (StarkNet)
</h2>
<p align="center">
  Base on, build upon and code for DAOs.
</p>
<p align="center">
  Make DAO the next generation of productivity tools for global collaboration.
</p>
<p align="center">
  Follow us on Twitter <a href="https://twitter.com/codefordao">@codefordao</a>.
</p>

<p align="center">
  <a href="https://github.com/CodeforDAO/contracts/">
    <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="mit license"/>
  </a>
</p>

> **This project is a work in progress, it has not been audited for code security and is being deployed in local development and test networks at this time. Please use with caution.**

The CodeforDAO contract is a set of DAO infrastructure and efficiency tools with member NFT at its core.

It is centered on a set of membership contracts for the `ERC721` protocol, the creation of its counterpart share contracts, two parallel governance frameworks and a timelock vault contract.

It introduces some basic features to DAO, including vault contracts for self-service participation in investments, a set of modular frameworks to support aggressive governance.

Read the full documents in this [Solidity Repo](https://github.com/CodeforDAO/contracts) of CodeforDAO contracts

## Set up the project

Before creating virtual environment, please **make sure** to install Python `3.7.12` using the Python version management tool and activate that version.

### Create a Python virtual environment

```bash
python -m venv env
source env/bin/activate
```

### Install the requirements

```bash
pip install -r requirements.txt
```

**Notice**: this project use the latest version of OpenZeppelin contract for Cairo instead of the stable release of it.

## Compile

```bash
nile compile --directory src
```

## Running tests

Running spec tests where you can find them in `./test` folder

```bash
$ pytest tests
```

## Use this module in your project

**Note:** these smart contracts are not designed to be library contracts(except `Module.cairo`), and you can fork these contracts locally to modify them yourself, rather than importing them directly by a git link.

```bash
pip install git+https://github.com/CodeforDAO/cairo-contracts.git
```

## License

This project is released under the [MIT](LICENSE).
