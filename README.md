# homebrew-tap

Homebrew formulae and casks for paulmeller tools.

```sh
brew install paulmeller/tap/<name>          # formulae
brew install --cask paulmeller/tap/<name>   # casks
```

`brew tap paulmeller/tap` first is optional — the three-part name taps it for
you.

## Formulae

| Name | |
|---|---|
| [`netsuite-cli`](Formula/netsuite-cli.rb) | CLI for the NetSuite API |
| [`warehouse`](Formula/warehouse.rb) | Fast CLI for personal data warehouse — extraction, FTS5 search, and browsing |
| [`xero-cli`](Formula/xero-cli.rb) | CLI for the Xero accounting API |

## Casks

| Name | |
|---|---|
| [`keepy-uppy`](Casks/keepy-uppy.rb) | [Keepy Uppy](https://github.com/paulmeller/keepy-uppy) — keeps a Mac awake with the lid closed |

### Uninstalling keepy-uppy

```sh
brew uninstall --cask keepy-uppy        # keeps your settings
brew uninstall --zap --cask keepy-uppy  # settings too
```

The uninstall runs `keepy-uppy reset` before removing anything, which asks the
daemon to hand back the machine's sleep behaviour before it is evicted.

**If that step refuses, the uninstall stops with the app still installed, and
that is correct.** The daemon owns a `SleepDisabled` setting that outlives both
the process and a reboot, so evicting it at the wrong moment leaves a Mac that
cannot sleep and nothing running that could fix it. Stop whatever is holding
the Mac awake — `keepy-uppy off --all` — then uninstall again.
