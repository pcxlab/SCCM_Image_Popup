Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ImagePath = Join-Path $PSScriptRoot "Happy_New_Year.jpg"

if (-not (Test-Path $ImagePath)) {
    return
}

$image = [System.Drawing.Image]::FromFile($ImagePath)

$form = New-Object System.Windows.Forms.Form
$form.Text = "Awareness Pop-up"
$form.WindowState = "Maximized"
$form.BackColor = "Black"
$form.KeyPreview = $true
$form.TopMost = $true
$form.StartPosition = "CenterScreen"

$form.Add_KeyDown({
    if ($_.KeyCode -eq "Escape") { $form.Close() }
})

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Dock = "Fill"
$pictureBox.SizeMode = "Zoom"
$pictureBox.Image = $image
$form.Controls.Add($pictureBox)

# Auto close after 15 seconds
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 15000
$timer.Add_Tick({
    $timer.Stop()
    $form.Close()
})
$timer.Start()

$form.ShowDialog()

$image.Dispose()
$form.Dispose()