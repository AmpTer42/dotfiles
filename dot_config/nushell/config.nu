# config.nu
#
# Installed by:
# version = "0.112.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
source ./starship.nu
source ./niri.nu
source ./plugins.nu
$env.config.show_banner = false
$env.config.edit_mode = "helix"
$env.XDG_SESSION_TYPE = "wayland"
$env.EDITOR = "/usr/bin/hx"
$env.path ++= ["~/.guix-profile/bin"]
$env.path ++= ["~/.config/guix/current/etc/profile"]
$env.path ++= ["/usr/local/cuda/bin"]
$env.path ++= ["~/.cargo/bin"]
$env.path ++= ["~/.local/bin"]
$env.path ++= ["/usr/bin"]
$env.path ++= ["/usr/bin"]
$env.path ++= ["~/go/bin"]
$env.LD_LIBRARY_PATH = ["/usr/local/cuda/lib64"]
$env.__GL_SHADER_DISK_CACHE_SIZE = 10737418240
$env.__GLX_VENDOR_LIBRARY_NAME = "nvidia"
$env.OLLAMA_GPU_NUM = 99
$env.WG_USERSPACE = 1
$env.GUIX_LOCPATH = "/home/vlodik/.guix-profile/lib/locale"
$env.GUIX_PROFILE = "/home/vlodik/.config/guix/current"
$env.QT_QPA_PLATFORMTHEME = "qt6ct"
alias l = ls -mdal
alias ll = ls -mdl
