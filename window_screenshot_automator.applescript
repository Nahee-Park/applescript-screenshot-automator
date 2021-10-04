set {year:y, month:m, day:d} to (current date)

--현재 시간으로 파일 저장하기 위해 포맷팅
to time_format(old_time)
	set {hours:h, minutes:m, seconds:s} to date old_time
	set pre to "am"
	if (h > 12) then
		set h to (h - 12)
		set pre to "pm"
	end if
	return (h & "시" & m & "분" & s & "초." & pre) as string
end time_format

set theDate to (current date)
set timeFormatted to time_format(time string of (theDate))

--현재 시간으로 파일 저장 
do shell script "defaults write com.apple.screencapture name " & timeFormatted & "&& killall SystemUIServer"
do shell script "screencapture -iW ~/Desktop/" & timeFormatted & ".png"

tell application "Finder"
	--activate
	set target of Finder window 1 to folder "Desktop" of folder "heeeee" of folder "Users" of startup disk
	--ScreenShot 파일 없으면 Desktop에 생성
	try
		make new folder at folder "Desktop" of folder "heeeee" of folder "Users" of startup disk with properties {name:"ScreenShot"}
	end try
	--ScreenShot 파일 내부에 오늘 날짜 파일 생성
	try
		make new folder at folder "ScreenShot" of folder "Desktop" of folder "heeeee" of folder "Users" of startup disk with properties {name:{y, m, d} as Unicode text}
	end try
	--Desktop 안에 있는 스크린샷 파일을 오늘 날짜 파일로 옮김
	set fileExtension to ("png")
	tell application "System Events"
		repeat with anItem in (get every file of (path to desktop) whose name extension is fileExtension)
			move anItem to POSIX file "/Users/heeeee/Desktop/ScreenShot/" & {y, m, d} as Unicode text with replacing
		end repeat
	end tell
end tell