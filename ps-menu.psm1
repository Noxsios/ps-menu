function DrawMenu {
	param ($menuItems, $menuPosition, $Multiselect, $selection)
	$l = $menuItems.length
	for ($i = 0; $i -le $l; $i++) {
		if ($null -ne $menuItems[$i]) {
			$item = $menuItems[$i]
			if ($Multiselect) {
				if ($selection -contains $i) {
					$item = '[x] ' + $item
				}
				else {
					$item = '[ ] ' + $item
				}
			}
			if ($i -eq $menuPosition) {
				Write-Host "» $($item)" -ForegroundColor Green
			}
			else {
				Write-Host "  $($item)"
			}
		}
	}
}

function ToggleSelection {
	param ($pos, [array]$selection)
	if ($selection -contains $pos) { 
		$result = $selection | Where-Object { $_ -ne $pos }
	}
	else {
		$selection += $pos
		$result = $selection
	}
	$result
}

function Menu {
	param ([array]$menuItems, [switch]$ReturnIndex = $false, [switch]$Multiselect)
	$vkeycode = 0
	$pos = 0
	$selection = @()
	[console]::CursorVisible = $false #prevents cursor flickering
	if ($menuItems.Length -gt 0) {
		DrawMenu $menuItems $pos $Multiselect $selection
		While ($vkeycode -ne 13 -and $vkeycode -ne 27) {
			$press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
			$vkeycode = $press.virtualkeycode
			if ($vkeycode -eq 38 -or $press.Character -eq 'k') { $pos-- }
			if ($vkeycode -eq 40 -or $press.Character -eq 'j') { $pos++ }
			if ($press.Character -eq ' ') { $selection = ToggleSelection $pos $selection }
			if ($pos -lt 0) { $pos = 0 }
			if ($vkeycode -eq 27) { $pos = $null }
			if ($pos -ge $menuItems.length) { $pos = $menuItems.length - 1 }
			if ($vkeycode -ne 27) {
				$startPos = [System.Console]::CursorTop - $menuItems.Length
				[System.Console]::SetCursorPosition(0, $startPos)
				DrawMenu $menuItems $pos $Multiselect $selection
			}
		}
	}
	else {
		$pos = $null
	}
	[console]::CursorVisible = $true

	if ($ReturnIndex -eq $false -and $null -ne $pos) {
		if ($Multiselect) {
			return $menuItems[$selection]
		}
		else {
			return $menuItems[$pos]
		}
	}
	else {
		if ($Multiselect) {
			return $selection
		}
		else {
			return $pos
		}
	}
}

