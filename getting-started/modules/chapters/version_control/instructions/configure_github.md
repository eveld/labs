## Create a GitHub account

If you do not have a [GitHub](https://www.github.com) account yet, [create](https://github.com/signup) one with the same email address as configured in the previous step.

## Generate an SSH key

In order to authenticate Git with GitHub it will need an SSH key.
To generate a new SSH key, open the terminal and execute the following command with the same email address you configured before:

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

This creates a new SSH key, using the provided email as a label to identify it by.

When you're prompted to "Enter a file in which to save the key", you can press Enter to accept the default file location. 
Please note that if you created SSH keys previously, ssh-keygen may ask you to rewrite another key, in which case we recommend creating a custom-named SSH key. 
To do so, type the default file location and replace id_ALGORITHM with your custom key name.

When prompted to enter a passphrase, type a secure passphrase and press Enter.
Please note that the entered passphrase will not be shown, so it might look like nothing is happening.
Type the same passphrase again and press Enter to confirm.

```shell
> Generating public/private ALGORITHM key pair.
> Enter a file in which to save the key (/Users/YOU/.ssh/id_ALGORITHM): [Press enter]
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

If everything went correct, you should be presented with a representation of your key in ASCII art.

```shell
The Key fingerprint is:
SHA256:FHs80yt3r2fehwfoweyufewhfweip your_name@example.com
The key's randomart image is:
+--[ED22519 256]--+
|       .++       |
|       .+..     .|
|     . .   . . ..|
|    . .     .E.. |
|     ...S     .  |
|      o+.        |
|     +..o        |
|  o B .o.        |
| . + +..         |
+-----[SHA256]----+
```

## Add an SSH key to your GitHub account
In order for GitHub to recognize that this newly generated SSH key is associated with your account, you need to add the key to your account.

First, copy the SSH public key to your clipboard.
In a terminal execute the following command, which will copy the contents of the SSH public key file to your clipboard:

{% tabs %}
{% tab title="macOS" %}
```shell
pbcopy < ~/.ssh/id_ed25519.pub
```
{% endtab %}
{% tab title="Linux" %}
```shell
cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard

```
{% endtab %}
{% tab title="Windows" %}
```shell
cat ~/.ssh/id_ed25519.pub | clip
```
{% endtab %}
{% endtabs %}

Then open up GitHub in the browser, sign in and follow the steps:

1. In the upper-right corner of any page on GitHub, click your profile photo, then click Settings.
2. In the "Access" section of the sidebar, click SSH and GPG keys.
3. Click New SSH key or Add SSH key.
4. In the "Title" field, add a descriptive label for the new key. 
   For example, if you're using a personal laptop, you might call this key "Personal laptop".
5. For the type of key, select authentication.
6. In the "Key" field, paste your public key.
7. Click Add SSH key.
8. If prompted, confirm access to your account on GitHub.

Your SSH key is now added to your GitHub account, and can be used by Git to authenticate itself as you when performing actions.