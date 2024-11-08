# ScoreKeeper
Keeps track of player scores over various board games.

## Dependencies

| Dependency     | Description        | Install                                                   |
| -------------- | ------------------ | --------------------------------------------------------- |
| ASDF           | Manages elixir     | [Website](https://asdf-vm.com/guide/getting-started.html) |
| Homebrew (Mac) | Package manager    | [Website](https://brew.sh)                                |
| Erlang OTP 27  | Runtime for elixir | Mac: `brew install erlang@27` (Other package managers may differ) |

### Running Localy

Install and setup dependencies.

```bash
git clone git@github.com:therealjasonkenney/score_keeper.git
cd score_keeper
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install
mix setup
```

To start your Phoenix server: `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Phoenix Framework: https://www.phoenixframework.org/


