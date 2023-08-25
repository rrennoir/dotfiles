export EDITOR=nvim
export VISUAL=$EDITOR

# Stupid poetry trying to use KDE wallet instead of the gnome one installed
export PYTHON_KEYRING_BACKEND=keyring.backends.SecretService.Keyring

