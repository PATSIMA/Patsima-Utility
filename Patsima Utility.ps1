Add-Type -AssemblyName System.Windows.Forms

# Función para ejecutar acciones según el tipo de dispositivo
function Invoke-Actions {
    param (
        [string]$deviceType
    )
    Clear-TextBox
    $actions[$deviceType] | ForEach-Object {
        $action = $_
        Add-Action $action
        switch ($action) {
            "Restore point" {
                # Restore point
                Checkpoint-Computer -Description "Punto de restauracion antes de la instalacion de Patsima Utility"
            }
            "Disable Activity History" {
                # Deshabilitar el historial de actividades
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0
            }
            "Disable GameDVR" {
                # Disable GameDVR
                Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Value 2
                Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
                Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1
                Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1
                Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Value 0
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0
            }
            "Disable Hibernation" {
                # Disable Hibernation
                Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Value 0
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Value 0
                powercfg.exe /hibernate off
            }
            "Disable Homegroup services" {
                # Disable Homegroup services
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HomeGroupListener" -Name "Start" -Value 3
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HomeGroupProvider" -Name "Start" -Value 3
            }
            "Disable Location Tracking" {
                # Disable Location Tracking
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -PropertyType String -Force
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value 0 -PropertyType DWORD -Force
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Value 0
                Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Value 0
            }
            "Services" {
                # Services
                Set-Service AxInstSV -StartupType Disabled
                Set-Service tzautoupdate -StartupType Disabled
                Set-Service bthserv -StartupType Disabled
                Set-Service dmwappushservice -StartupType Disabled
                Set-Service MapsBroker -StartupType Disabled
                Set-Service lfsvc -StartupType Disabled
                Set-Service SharedAccess -StartupType Disabled
                Set-Service lltdsvc -StartupType Disabled
                Set-Service AppVClient -StartupType Disabled
                Set-Service NetTcpPortSharing -StartupType Disabled
                Set-Service CscService -StartupType Disabled
                Set-Service PhoneSvc -StartupType Disabled
                Set-Service Spooler -StartupType Disabled
                Set-Service PrintNotify -StartupType Disabled
                Set-Service QWAVE -StartupType Disabled
                Set-Service RmSvc -StartupType Disabled
                Set-Service RemoteAccess -StartupType Disabled
                Set-Service SensorDataService -StartupType Disabled
                Set-Service SensrSvc -StartupType Disabled
                Set-Service SensorService -StartupType Disabled
                Set-Service ShellHWDetection -StartupType Disabled
                Set-Service SCardSvr -StartupType Disabled
                Set-Service ScDeviceEnum -StartupType Disabled
                Set-Service SSDPSRV -StartupType Disabled
                Set-Service WiaRpc -StartupType Disabled
                Set-Service TabletInputService -StartupType Disabled
                Set-Service upnphost -StartupType Disabled
                Set-Service UserDataSvc -StartupType Disabled
                Set-Service UevAgentService -StartupType Disabled
                Set-Service WalletService -StartupType Disabled
                Set-Service FrameServer -StartupType Disabled
                Set-Service stisvc -StartupType Disabled
                Set-Service wisvc -StartupType Disabled
                Set-Service icssvc -StartupType Disabled
                Set-Service WSearch -StartupType Disabled
                Set-Service XblAuthManager -StartupType Disabled
                Set-Service XblGameSave -StartupType Disabled
                Set-Service SEMgrSvc -StartupType Disabled
                Set-Service DiagTrack -StartupType Disabled
            }
            "TweaksStorage" {
                # TweaksStorage
                Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force -Confirm:$false
                New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force    
            }
            "Disable Telemetry" {
            # Deshabilitar TelemetryController
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" -Name "DisableInventory" -Value 1
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" -Name "DisableOutbound" -Value 1

            # Deshabilitar de AutoChkProxy
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "AutoChkProxy" -Value 0

            # Deshabilitar CEIP (Customer Experience Improvement Program)
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Value 0

            # Deshabilitar Diagnostico de Disco
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\DiskDiagnostic" -Name "DisableDiskDiagnosisExecution" -Value 1

            # Deshabilitar Windows Error Reporting
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "QueueReporting" -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1

            # Deshabilitar de AllowTelemetry
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0

            # Deshabilitar de ContentDeliveryManager
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0

            # Deshabilitar de CloudContent
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value 1

            # Deshabilitar AdvertisingInfo
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 1

            # Deshabilitar de DeliveryOptimization
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 1

            # Deshabilitar de Remote Assistance
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0

            # Deshabilitar de OperationStatusManager
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Value 1

            # Deshabilitar de Explorer
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PeopleBand" -Value 0
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1

            # Deshabilitar de FileSystem
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1

            # Deshabilitar de DriverSearching
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 1

            # Deshabilitar de Multimedia\SystemProfile
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295

            # Deshabilitar de Desktop
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "1"
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value "1"
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Value "400"

            # Deshabilitar de LanmanServer
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Value 30

            # Deshabilitar de Windows Feeds
            Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2

            # Deshabilitar de Explorer\Policies
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

            # Deshabilitar de Multimedia\SystemProfile\Tasks\Games
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8 -PropertyType DWORD -Force
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6 -PropertyType DWORD -Force
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High"
            }
            "PowerPlan" {
            powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
            powercfg.exe /changename 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c PatsimaUtility
            powercfg.exe /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
            powercfg.exe /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
            powercfg.exe /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100
            powercfg.exe /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 100
            powercfg.exe /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 5000
            powercfg.exe /setactive scheme_current
            }
            "OOSU10" {
                # OOSU10
                curl.exe -s "https://raw.githubusercontent.com/PATSIMA/Patsima-Utility/main/ooshutup10.cfg" -o "$env:temp\ooshutup10.cfg"
                curl.exe -s "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -o "$env:temp\OOSU10.exe"
                Start-Process -FilePath "$env:temp\OOSU10.exe" -ArgumentList "/quiet", "$env:temp\ooshutup10.cfg" -NoNewWindow -Wait
            }
            "SVHOST" {
                # SVHOST
                reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f
            }
            "Reiniciando" {
                # Reiniciando
                Restart-Computer -Force -Timeout 7 -Message "Patsima Utility COMPLETADO: REINICIANDO"
            }
            "Stop Updates" {
                # Stop Updates
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DoNotConnectToWindowsUpdateInternetLocations" -Value 0 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DisableWindowsUpdateAccess" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUServer" -Value "" -PropertyType String -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUStatusServer" -Value "" -PropertyType String -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "UpdateServiceUrlAlternate" -Value "" -PropertyType String -Force | Out-Null
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" -Name "AutoDownload" -Value 2 -PropertyType DWORD -Force | Out-Null
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Value 0 -PropertyType DWORD -Force | Out-Null
                New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWORD -Force | Out-Null
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Value 1 -PropertyType DWORD -Force | Out-Null
            }
        }
    }
}

# Definir acciones para cada tipo de dispositivo
$actions = @{
    "desktop" = @(
        "Restore point",
        "Disable Activity History",
        "Disable GameDVR",
        "Disable Hibernation",
        "Disable Homegroup services",
        "Disable Location Tracking",
        "OOSU10",
        "Services",
        "TweaksStorage",
        "Disable Telemetry",
        "PowerPlan"
        "SVHOST"
        "Reiniciando"
    )
    "laptop" = @(
        "Restore point",
        "Disable Activity History",
        "Disable GameDVR",
        "Disable Homegroup services",
        "Disable Location Tracking",
        "OOSU10",
        "Services",
        "TweaksStorage",
        "Disable Telemetry",
        "PowerPlan"
        "SVHOST"
        "Reiniciando"
    )
    "minimal" = @(
        "Restore point",
        "Disable Homegroup services",
        "OOSU10",
        "Services",
        "Disable Telemetry"
        "SVHOST"
        "Reiniciando"
    )
    "updates" = @(
        "Restore point",
        "Stop Updates"
        "Reiniciando"
    )
}


# Función para agregar acción al cuadro de texto
function Add-Action {
    param (
        [string]$action
    )
    $textBox.AppendText("$action`r`n")
}

# Función para limpiar el cuadro de texto
function Clear-TextBox {
    $textBox.Clear()
}

# Crear formulario
$PatsimaUtilityForm = New-Object System.Windows.Forms.Form
$PatsimaUtilityForm.Text = "Patsima Utility"
$PatsimaUtilityForm.Size = New-Object System.Drawing.Size(700, 400)
$PatsimaUtilityForm.StartPosition = "CenterScreen"
$PatsimaUtilityForm.BackColor = "#141414"  # Color de fondo oscuro
$PatsimaUtilityForm.FormBorderStyle = "FixedSingle"  # Bloquea el tamaño
$PatsimaUtilityForm.MaximizeBox = $false  # Deshabilita el botón de maximizar
$iconUrl = "https://raw.githubusercontent.com/PATSIMA/Patsima-Utility/main/Utility.ico"
$iconPath = "$env:TEMP\Utility.ico"  # Ruta temporal para guardar el icono descargado
Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath

# Verificar si se descargó el icono correctamente
if (Test-Path $iconPath) {
    # Asociar el icono con el formulario
    $PatsimaUtilityForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
} else {
    Write-Host "Error al descargar el icono desde la URL."
}


# Crear panel para mostrar acciones de botones
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(50, 70)
$panel.Size = New-Object System.Drawing.Size(600, 250)
$panel.BackColor = "#1f1f1f"  # Color de fondo del panel oscuro

# Crear cuadro de texto para mostrar acciones
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Multiline = $true
$textBox.Location = New-Object System.Drawing.Point(10, 10)
$textBox.Size = New-Object System.Drawing.Size(580, 230)
$textBox.BackColor = "#1f1f1f"
$textBox.ForeColor = "#ffffff"
$textBox.ReadOnly = $true
$textBox.BorderStyle = "None"
$segoeFont = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$textBox.Font = $segoeFont
$textBox.Padding = New-Object System.Windows.Forms.Padding(5)

# Agregar cuadro de texto al panel
$panel.Controls.Add($textBox)

# Crear botones
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Desktop"
$button1.Location = New-Object System.Drawing.Point(50, 25)
$button1.BackColor = "#282828"  # Color de fondo del botón oscuro
$button1.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button1.FlatStyle = "Flat"  # Botón plano
$button1.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button1.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button1.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button1.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button1.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo desktop
    Execute-Actions "desktop"
})

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Laptop"
$button2.Location = New-Object System.Drawing.Point(170, 25)
$button2.BackColor = "#282828"  # Color de fondo del botón oscuro
$button2.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button2.FlatStyle = "Flat"  # Botón plano
$button2.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button2.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button2.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button2.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button2.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo laptop
    Execute-Actions "laptop"
})

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Minimal"
$button3.Location = New-Object System.Drawing.Point(290, 25)
$button3.BackColor = "#282828"  # Color de fondo del botón oscuro
$button3.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button3.FlatStyle = "Flat"  # Botón plano
$button3.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button3.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button3.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button3.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button3.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo minimal
    Execute-Actions "minimal"
})

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "Updates"
$button4.Location = New-Object System.Drawing.Point(410, 25)
$button4.BackColor = "#282828"  # Color de fondo del botón oscuro
$button4.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button4.FlatStyle = "Flat"  # Botón plano
$button4.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button4.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button4.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button4.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button4.Add_Click({
    Execute-Actions "Updates"
})

# Agregar botones al formulario
$PatsimaUtilityForm.Controls.Add($button1)
$PatsimaUtilityForm.Controls.Add($button2)
$PatsimaUtilityForm.Controls.Add($button3)
$PatsimaUtilityForm.Controls.Add($button4)

# Agregar panel al formulario
$PatsimaUtilityForm.Controls.Add($panel)

# Mostrar formulario
$PatsimaUtilityForm.ShowDialog()

# Limpiar recursos
$PatsimaUtilityForm.Dispose()
