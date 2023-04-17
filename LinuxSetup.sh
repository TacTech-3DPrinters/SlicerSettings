
# Ensure we don't skip errors
set -e

# Bash function to symlink the configs
symlink_config() {
    # 1st argument is the name of the config directory in the repo
    src_dir=$(realpath -s $1)
    # 2nd argument is the target config directory (where the slicer expects the configs)    
    dest_dir=$(realpath -s "$2")
    
    # First, test to see if we have an existing correct symlink
    if [ -L $dest_dir ] && [ $(readlink $dest_dir) == $src_dir ] ; then
        printf "Correct symlink detected between $src_dir and $dest_dir\n"
        printf "No changes made.\n\n"
        return
    fi

    # If a directory exists, confirm with user if they should delete it
    if [ -d "$dest_dir" ]; then
        printf "This will permanently delete existing configs in $dest_dir and replace them with configs from $src_dir\n"
        read -p "Are you sure you'd like to delete your existing configs? (y/n)" response
        if [[ $response == "y" || $response == "Y" ]]; then
            printf "Deleting $dest_dir...\n"
            rm -rf $dest_dir
        else
            printf "Cancelling the symlink between $src_dir and $dest_dir\n\n"
            return
        fi
    fi    

    # Finally, create a symlink between src_dir and dest_dir
    printf "Creating a symlink between $src_dir and $dest_dir\n"
    ln -sf $src_dir $dest_dir
    printf "Done!\n\n"

}

# PrusaSlicer Alpha configs
symlink_config "PrusaSlicerAlpha" "$HOME/.config/PrusaSlicer-alpha"

# PrusaSlicer configs
symlink_config "PrusaSlicer" "$HOME/.config/PrusaSlicer"