# dx-docker-login-manager

`dx-docker-login-manager` is an oh-my-zsh plugin that allows you to manage multiple Docker login profiles and easily switch between them from your terminal.

## Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/gergosofalvi/dx-docker-login-manager.git ~/.oh-my-zsh/custom/plugins/docker-login-manager
    ```

2. **Add the plugin to your `.zshrc` file:**

    Open your `.zshrc` file in your favorite text editor and add `docker-login-manager` to the list of plugins:

    ```sh
    plugins=(git docker-login-manager)
    ```

3. **Reload your ZSH configuration:**

    ```sh
    source ~/.zshrc
    ```

4. **Ensure you have the required dependencies installed:**

    `dx-docker-login-manager` relies on `jq` and `fzf`. Install them using the following commands:

    ```sh
    brew install jq fzf
    ```

## Usage

### Adding a Docker login profile

To add a new Docker login profile, use the `dx-add` command:

```sh
dx-add
```

You will be prompted to enter your Docker username, password, and server (default: https://index.docker.io/v1/).

## Removing a Docker login profile
To remove an existing Docker login profile, use the dx-remove command:

```sh
dx-remove
```

## Viewing the current Docker login profile
To view the currently active Docker login profile, simply run:

```sh
dx
```
This will output the currently logged in profile:

```sh
Current profile logged in: ProfileName
```
## Switching Docker login profiles
To switch to a different Docker login profile, use the dx command followed by the profile name:

```sh
dx profileName
```
This will automatically log out of the current profile and log in with the selected profile.

##Auto-completion
The dx command supports auto-completion for profile names. Simply start typing the profile name and press Tab to see available profiles.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to customize the README as needed. This should provide a clear and concise guide for users to install and use the `dx-docker-login-manager` plugin.





