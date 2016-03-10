#!/bin/bash

brewup_file=/usr/local/bin/brewup
launch_agent=~/Library/LaunchAgents/brewup.job.plist

echo " --- Creating brew maintenance script at: $brewup_file"

touch $brewup_file

cat <<-END > "$brewup_file"
#!/bin/bash

brew=/usr/local/bin/brew
logger=/usr/bin/logger

\$brew update 2>&1  | \$logger -t brewup.update
\$brew upgrade 2>&1 | \$logger -t brewup.upgrade
\$brew cleanup 2>&1 | \$logger -t brewup.cleanup
END
chmod +x $brewup_file

echo " --- Creating launch agent at: $launch_agent"

touch $launch_agent

echo " --- Loading launch agent $launch_agent"

cat <<-END > "$launch_agent"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>local.homebrew.maintenance</string>
  <key>Program</key>
  <string>/usr/local/bin/brewup</string>
  <key>StartInterval</key>
  <integer>10800</integer>
</dict>
</plist>
END

echo " --- Running brew maintenance now..."

$brewup_file&

echo " --- Run: tail -f /var/log/system.log to monitor updates..."