## Setting up the Instruqt GitHub integration

In order to integrate GitHub with Instruqt, you need to set up the integration.

### Configure integration

Navigate to the Version Control settings page.

![](/assets/vcs/install_integration.png)

The VCS integrations are listed, with GitHub currently being the only option. Click the "Install" button on the GitHub integration to install the Instruqt GitHub application in your GitHub organization. 
You will then be redirected to GitHub, where you are taken through the GitHub application installation flow.

### Select organization

First you need to select the organization you want to install the application in.

![](/assets/vcs/choose_github_target.png)

Depending on your settings, the flow might ask you to provide two-factor authentication details to GitHub.

### Configure permissions

You are then taken to the application permissions page, where you can review which permissions the application wants to use.

The permissions that the Instruqt GitHub application needs are:

- Read access to metadata (this is the default permissions for an application)
  - read the organization name, etc.
- Read and write access to code
  - This allows the integration to read the contents of a track repository, so it can update the data in the Instruqt platform with any changes made through GitHub.
  - This allows the integration to write changes made in the instruqt UI back to the track repository on GitHub.

You can choose to give the permissions on all repositories in the organization, or to specific repositories only.

### Install GitHub application

To complete the installation, click “Install” to confirm your choices and install the application.

![](/assets/vcs/choose_permissions.png)

You are then taken back to the Version Control settings page, which now shows that the integration was successfully installed.

![](/assets/vcs/install_integration_completed.png)