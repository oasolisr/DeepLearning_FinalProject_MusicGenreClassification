# Create required directories
New-Item -Path "data\mp3" -ItemType Directory -Force
New-Item -Path "data\plots" -ItemType Directory -Force
New-Item -Path "data\models" -ItemType Directory -Force

# Download first archive
Write-Host "Downloading first archive..."
Invoke-WebRequest -Uri "http://mi.soi.city.ac.uk/datasets/magnatagatune/mp3.zip.001" -OutFile "data\mp3\mp3.zip.001"

# Download second archive
Write-Host "Downloading second archive..."
Invoke-WebRequest -Uri "http://mi.soi.city.ac.uk/datasets/magnatagatune/mp3.zip.002" -OutFile "data\mp3\mp3.zip.002"

# Download third archive
Write-Host "Downloading third archive..."
Invoke-WebRequest -Uri "http://mi.soi.city.ac.uk/datasets/magnatagatune/mp3.zip.003" -OutFile "data\mp3\mp3.zip.003"

# Combine archives into a single zip file
Write-Host "Combining archives into a single file..."
Copy-Item "data\mp3\mp3.zip.001" -Destination "data\mp3\mp3.zip"
Add-Content -Path "data\mp3\mp3.zip" -Value (Get-Content "data\mp3\mp3.zip.002" -Raw)
Add-Content -Path "data\mp3\mp3.zip" -Value (Get-Content "data\mp3\mp3.zip.003" -Raw)

# Unzip the combined file
Write-Host "Extracting archives..."
Expand-Archive -Path "data\mp3\mp3.zip" -DestinationPath "data\mp3"

# Move mp3 files to the correct folder
Write-Host "Moving mp3 files..."
Get-ChildItem -Recurse -Filter "*.mp3" | Move-Item -Destination "data\mp3"

# Clean up any remaining zip files
Remove-Item "data\mp3\*.zip*"

# Create CSV directory and download CSV data
New-Item -Path "data\csv" -ItemType Directory -Force
Write-Host "Downloading CSV data..."
Invoke-WebRequest -Uri "http://he3.magnatagatune.com/info/song_info.csv" -OutFile "data\csv\song_info.csv"

# Run the shell script (if applicable for Windows, replace or adapt if necessary)
Write-Host "Running init_genre_dir.sh script..."
# Assuming you have a PowerShell script or equivalent function to initialize genre directories
# .\init_genre_dir.ps1 data\wav

Write-Host "Converting mp3s to wavs..."
# Assuming you have a Python script to convert mp3 to wav
python util\make_wav.py
