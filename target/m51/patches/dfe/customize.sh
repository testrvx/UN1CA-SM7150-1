LOG_STEP_IN "- Enabling force encryption in fstab files"
patch_fstab() {
    local file="$1"
    # Check if the userdata line exists and does NOT already contain 'fileencryption'
    if grep -q "userdata" "$file" && ! grep -q "fileencryption" "$file"; then
        # Append the encryption flag to the end of the line
        # (The $ in sed represents the end of the line)
        sed -i '/userdata/ s/$/,fileencryption=ice/' "$file"
    fi
}

for fstab in "${WORK_DIR}"/vendor/etc/fstab.*; do
    patch_fstab "$fstab"
done
LOG_STEP_OUT 

unset -f patch_fstab
