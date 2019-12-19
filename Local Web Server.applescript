(*
	Local Web Server
	Version 1.0 Ð December 19, 2019
*)

property host : "localhost"
property port : 8080
property pid : missing value

on run
	try
		set choosen_folder to choose folder with prompt "Choose the root foolder of your website:"
	on error err_msg number err_num
		if err_num is equal to -128 then
			quit
		else
			beep
			display dialog err_msg buttons {"OK"} default button "OK"
			quit
		end if
	end try
	my checkKirby(choosen_folder)
end run

on open dropped_items
	if (count items of dropped_items) is greater than 1 then
		beep
		display alert "Too many items" message Â
			"Please open only one folder at a time." buttons {"OK"} default button "OK"
		quit
	else
		tell application id "com.apple.Finder"
			set isFolder to folder (item 1 of dropped_items as string) exists
		end tell
		if isFolder = true then
			my checkKirby(item 1 of dropped_items)
		else
			beep
			display alert "Not a folder" message Â
				"A file canÕt be processed, only a folder." buttons {"OK"} default button "OK"
			quit
		end if
	end if
end open

on checkKirby(choosen_folder)
	tell application id "com.apple.Finder"
		if exists file "router.php" of folder "kirby" of choosen_folder then
			-- if kirby is present
			my runServer(true, quoted form of POSIX path of choosen_folder)
		else
			-- regular folder without kirby
			my runServer(false, quoted form of POSIX path of choosen_folder)
		end if
	end tell
end checkKirby

on runServer(is_kirby, path_to_folder)
	if is_kirby is true then
		try
			set pid to do shell script "cd" & space & path_to_folder & ";" & "php -S" & space & Â
				host & ":" & port & space & Â
				"kirby/router.php" & Â
				" > /dev/null 2>&1 & echo $!"
		on error err_msg
			display dialog err_msg buttons {"OK"} default button "OK"
		end try
	else
		try
			set pid to do shell script "cd" & space & path_to_folder & ";" & Â
				"php -S" & space & Â
				host & ":" & port & Â
				" > /dev/null 2>&1 & echo $!"
		on error err_msg
			display dialog err_msg buttons {"OK"} default button "OK"
		end try
	end if
	
	set ask_show_served to display dialog Â
		"Would you like to see the local served website?" buttons Â
		{"Cancel", "Show"} default button "Show" cancel button "Cancel" giving up after 30
	if button returned of ask_show_served is equal to "Show" then
		open location "http://" & host & ":" & port
	end if
	
end runServer

on quit
	try
		do shell script "kill" & space & pid
	end try
	continue quit
end quit