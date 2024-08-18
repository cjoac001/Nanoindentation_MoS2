#!/bin/bash

# Define the source directory containing the files
source_dir="/storage/home/cpj5352/work/ProjectMoS2/MoS2_Expanded/Epot=500/Trial_2_Forces/"

# Define the destination directory where folders will be created
dest_dir="/storage/home/cpj5352/work/ProjectMoS2/MoS2_Expanded/Epot=500/Trial_2_Forces/"

# Define the common files
common_files=("adf.job" "piston.in" "control" "ffield" "geo")

# Loop to generate folders and copy files
for i in {1..51}; do
  # Format the unique file name
  unique_file=$(printf "molsav-%04d" $i)
  
  # Create a new folder for each unique file
  folder_name="$dest_dir/folder_$i"
  mkdir -p "$folder_name"
  
  # Copy common files to the new folder
  for common_file in "${common_files[@]}"; do
    cp "$source_dir/$common_file" "$folder_name"
  done
  
  # Copy the unique file to the new folder
  cp "$source_dir/$unique_file" "$folder_name/vels"	
  
   # Ensure adf.job is executable
  chmod +x "$folder_name/adf.job"

  # Run adf.job in the new folder
  (cd "$folder_name" && sbatch adf.job) &
done
# Wait for all background jobs to finish
wait

echo "Folders created and executed successfully."

