The Instruqt command-line tool can be used to initialize, format and validate your lab.

## Example usage

```
❯ instruqt lab --help
Create and manage labs

Usage:
  instruqt lab [command]

Available Commands:
  format      Format the lab config at the given path
  init        Initialize a new lab from an example
  validate    Validate a local lab

Flags:
  -h, --help   help for lab

Use "instruqt lab [command] --help" for more information about a command.
```

## Install the Instruqt CLI <a href="#install-cli" id="install-cli"></a>

The CLI is available on macOS, Windows and Linux, and can be installed using either a [package manager](install-instruqt-cli.md#using-a-package-manager) (recommended), or [manually](install-instruqt-cli.md#manually-from-the-latest-release) from GitHub releases.

### Using a package manager

{% tabs %}
{% tab title="macOS (homebrew)" %}
1. Open a terminal
2.  Install the CLI using [Homebrew](https://brew.sh)

    <pre><code><strong>brew install instruqt/tap/instruqt
    </strong></code></pre>
3.  Confirm the Instruqt CLI was installed correctly:

    ```
    instruqt lab --help
    ```
{% endtab %}

{% tab title="Windows (winget)" %}
1. Open a PowerShell window
2.  Install the CLI using [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/):

    <pre><code><strong>winget install instruqt
    </strong></code></pre>
3. Close and re-open the PowerShell window
4.  Confirm the Instruqt CLI was installed correctly:

    ```
    instruqt lab --help
    ```
{% endtab %}

{% tab title="Linux (coming soon)" %}
Distributions for `apt` and `rpm` based systems will be available soon. Until then, please refer to the manual install below.
{% endtab %}
{% endtabs %}

### Manually from the latest release

Instruqt CLI releases are published to GitHub. You can download the latest release for your Operating System from [https://github.com/instruqt/cli/releases/latest](https://github.com/instruqt/cli/releases/latest). Refer to the instructions below how to install these for your system.

{% tabs %}
{% tab title="macOS" %}
1. Open a terminal.
2.  Download the appropriate CLI **(Apple Silicon or Intel Macbook, in that order):**

    ```bash
    curl -L https://github.com/instruqt/cli/releases/latest/download/instruqt-darwin-arm64.zip -o instruqt.zip
    ```

    ```bash
    curl -L https://github.com/instruqt/cli/releases/latest/download/instruqt-darwin-amd64.zip -o instruqt.zip
    ```
3.  Extract the CLI binary:

    ```bash
    unzip instruqt.zip
    ```
4.  Copy the binary to your local `bin` directory:

    ```bash
    sudo cp instruqt /usr/local/bin
    ```
5.  Make the binary executable:

    ```bash
    sudo chmod +x /usr/local/bin/instruqt
    ```
6.  Confirm the Instruqt CLI was installed correctly:

    ```
    instruqt lab --help
    ```

{% hint style="info" %}
**Need help?**\
Here's a [video tutorial](https://www.youtube.com/watch?v=6N1c5kMU4P4) to guide you through the installation process.
{% endhint %}
{% endtab %}

{% tab title="Windows" %}
1. Open a PowerShell window.
2.  Copy and paste the following code:

    ```powershell
    mkdir scripts
    cd scripts
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($pwd.Path)", "User")
    Invoke-WebRequest -Uri https://github.com/instruqt/cli/releases/latest/download/instruqt-windows.zip -OutFile "instruqt.zip"
    Expand-Archive instruqt.zip -d .
    rm instruqt.zip
    ```
3. Close and re-open your Powershell window to detect the new program.
4.  Enter the following command to check if Instruqt CLI was installed correctly:

    ```
    instruqt lab --help
    ```

{% hint style="info" %}
**Need help?**\
Here's a [video tutorial](https://www.youtube.com/watch?v=i4WH5WU_20w) to guide you through the installation process.
{% endhint %}
{% endtab %}

{% tab title="Linux" %}
1. Open a terminal.
2.  Download the CLI:

    ```bash
    curl -L https://github.com/instruqt/cli/releases/latest/download/instruqt-linux.zip -o instruqt.zip
    ```
3.  Extract the CLI binary:

    ```bash
    unzip instruqt.zip
    ```
4.  Copy the binary to your local `bin` directory:

    ```bash
    sudo cp instruqt /usr/local/bin
    ```
5.  Make the binary executable:

    ```bash
    sudo chmod +x /usr/local/bin/instruqt
    ```
6.  Confirm the Instruqt CLI was installed correctly:

    ```bash
    instruqt lab --help
    ```

{% hint style="info" %}
**Need help?**\
Here's a [video tutorial](https://www.youtube.com/watch?v=i4WH5WU_20w) to guide you through the installation process.
{% endhint %}
{% endtab %}
{% endtabs %}

{% hint style="info" %}
The Instruqt CLI collects basic usage information and sends crash reports by default. No personal information is collected. You can disable these behaviours by following this guide.
{% endhint %}