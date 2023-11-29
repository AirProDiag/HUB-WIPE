# PowerShell script to enable a driver

# Start PowerShell with Admin rights
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!" -ForegroundColor Red
    exit
}



$driverNamePattern = "Intel(R) USB 3.1*"

# Fetch all drivers, including hidden ones
$drivers = Get-PnpDevice -Class 'USB' | Where-Object { $_.FriendlyName -like $driverNamePattern }

# Get unique INF names
$driverInfs = $drivers | ForEach-Object {
    $deviceProperty = Get-PnpDeviceProperty -InstanceId $_.InstanceId -KeyName 'DEVPKEY_Device_DriverInfPath'
    if ($deviceProperty) {
        $deviceProperty.Data
    }
} | Select-Object -Unique

# Check if drivers are found and INF names are retrieved
if ($driverInfs) {
    foreach ($driverInf in $driverInfs) {
        if ($driverInf) {
            Write-Output "Uninstalling driver with INF: $driverInf"
            pnputil /delete-driver $driverInf /uninstall
        }
    }
} else {
    Write-Output "Driver not found or unable to retrieve INF files."
}




$driverNamePattern = "USB Root Hub*"

# Fetch all drivers, including hidden ones
$drivers = Get-PnpDevice -Class 'USB' | Where-Object { $_.FriendlyName -like $driverNamePattern }

# Get unique INF names
$driverInfs = $drivers | ForEach-Object {
    $deviceProperty = Get-PnpDeviceProperty -InstanceId $_.InstanceId -KeyName 'DEVPKEY_Device_DriverInfPath'
    if ($deviceProperty) {
        $deviceProperty.Data
    }
} | Select-Object -Unique

# Check if drivers are found and INF names are retrieved
if ($driverInfs) {
    foreach ($driverInf in $driverInfs) {
        if ($driverInf) {
            Write-Output "Uninstalling driver with INF: $driverInf"
            pnputil /delete-driver $driverInf /uninstall
        }
    }
} else {
    Write-Output "Driver not found or unable to retrieve INF files."
}


