# Silent Install 7-Zip
# http://www.7-zip.org/download.html 
# Bryan Valarezo

# Path for the tempdir
$workdir = ($env:TEMP)

# Check if work directory exists if not create it

# Download the installer

$DownloadPage = "https://www.7-zip.org/download.html"
$WebRequest = Invoke-WebRequest $DownloadPage
$ListOfLinks = $WebRequest.ParsedHtml.getElementsByTagName("a") | % ie8_href
$ListofMsi = $ListofLinks | Select-String -Pattern '-x64.msi'
$SourceString = $ListofMsi | Select -First 1 #we can assume the most current msi is at the top
$SourceURL = "http://www.7-zip.org/a/" + $SourceString.Line.Substring(8, $SourceString.Line.length-8)

$destination = "$workdir\7-Zip.msi"

Invoke-WebRequest $sourceURL -OutFile $destination 

# Start the installation

msiexec.exe /i "$workdir\7-Zip.msi" /qb

# Wait XX Seconds for the installation to finish