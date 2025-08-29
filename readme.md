# `pac-land`

A simple, user-friendly Bash script to automate the installation of your favorite applications on Arch Linux. This project leverages the `yay` AUR helper to provide a one-command solution for setting up your system with a curated list of software from both the official repositories and the Arch User Repository (AUR).

## ✨ Features

- **One-Command Setup**: Get all your essential applications installed with a single command.
- **Intelligent Package Management**: Automatically handles installation from both official Pacman repositories and the Arch User Repository (AUR).
- **Customizable Application List**: Easily add or remove applications by editing a simple text file.
- **User-Friendly Interface**: Provides clear, color-coded logs to show the status of each installation.
- **Automated System Update**: Ensures your system is fully updated before installing new software to prevent dependency issues.
- **Idempotent**: The script will not reinstall applications that are already present on your system.
- **Yay Installation**: The script will automatically install the `yay` AUR helper if it is not already found on your system.

---

## 📋 Prerequisites

- A fresh installation of Arch Linux.
- An active internet connection.

---

## 🚀 Installation & Usage

1.  **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/pac-land.git
    cd pac-land
    ```

2.  **Customize your apps list (Optional)**:
    Open the `apps.txt` file and add or remove application names. Ensure each app is on a new line. The script will automatically skip comments (lines starting with `#`) and blank lines.

    **`apps.txt` example:**

    ```
    # Media and Entertainment
    spotify
    mpv

    # Developer Tools
    git
    insomnia-bin
    ```

3.  **Run the script**:
    Make the script executable and run it from your terminal. The script will first update your system, then install `yay` (if needed), and finally install all the applications from your list.

    ```bash
    chmod +x install-apps.sh
    ./install-apps.sh
    ```

    Alternatively, you can specify a different apps list file:

    ```bash
    ./install-apps.sh my-custom-list.txt
    ```

---

## 🛠️ How It Works

The script is a simple Bash script that uses the powerful `yay` package manager.

1.  **Update**: It runs `yay -Syu --noconfirm` to ensure your system and all installed packages are up to date.
2.  **Read File**: It reads the list of applications from the `apps.txt` file line by line.
3.  **Install**: For each application, it runs `yay -S <app_name> --needed --noconfirm`. The `yay` command is intelligent and automatically determines whether the package comes from the official repositories or the AUR.
4.  **Error Handling**: The script checks the exit status of each `yay` command and provides clear `[INFO]`, `[WARN]`, and `[ERROR]` logs.

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
