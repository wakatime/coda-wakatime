
History
-------


2.0.0 (2018-12-19)
++++++++++++++++++

- Upgrade wakatime-cli to v10.6.1.
- Correctly parse include_only_with_project_file when set to false.
  `wakatime#161 <https://github.com/wakatime/wakatime/issues/161>`_
- Support language argument for non-file entity types.
- Send 25 heartbeats per API request.
- New category "Writing Tests".
  `wakatime#156 <https://github.com/wakatime/wakatime/issues/156>`_
- Fix bug caused by git config section without any submodule option defined.
  `wakatime#152 <https://github.com/wakatime/wakatime/issues/152>`_
- Send 50 offline heartbeats to API per request with 1 second delay in between.
- Support logging coding activity to remote network drive files on Windows
  platform by detecting UNC path from drive letter.
  `wakatime#72 <https://github.com/wakatime/wakatime/issues/72>`_
- Re-enable detecting projects from Subversion folder on Windows platform.
- Prevent opening cmd window on Windows when detecting project from Subversion.
- Run tests on Windows using Appveyor.
- Default --sync-offline-activity to 100 instead of 5, so offline coding is
  synced to dashboard faster.
- Batch heartbeats in groups of 10 per api request.
- New config hide_project_name and argument --hide-project-names for
  obfuscating project names when sending coding activity to api.
- Fix mispelled Gosu language.
  `wakatime#137 <https://github.com/wakatime/wakatime/issues/137>`_
- Remove metadata when hiding project or file names.
- New --local-file argument to be used when --entity is a remote file.
- New argument --sync-offline-activity for configuring the maximum offline
  heartbeats to sync to the WakaTime API.
- Support for project detection from git worktree folders.
- Force forward slash for file paths.
- New --category argument.
- New --exclude-unknown-project argument and corresponding config setting.
- Smarter C vs C++ vs Objective-C language detection.
- Detect dependencies from Elm, Haskell, Haxe, Kotlin, Rust, and Scala files.
- Improved Matlab vs Objective-C language detection.
  `wakatime#129 <https://github.com/wakatime/wakatime/issues/129>`_
- Detect dependencies from Swift, Objective-C, TypeScript and JavaScript files.
- Categorize .mjs files as JavaScript.
  `wakatime#121 <https://github.com/wakatime/wakatime/issues/121>`_
- Ability to only track folders containing a .wakatime-project file using new
  include_only_with_project_file argument and config option.
- Fix bug that caused heartbeats to be cached locally instead of sent to API.
- Improve Java dependency detection.
- Skip null or missing heartbeats from extra heartbeats argument.
- Support saving unicode heartbeats when working offline.
  `wakatime#112 <https://github.com/wakatime/wakatime/issues/112>`_
- Limit bulk syncing to 5 heartbeats per request.
  `wakatime#109 <https://github.com/wakatime/wakatime/issues/109>`_
- Parse array of results from bulk heartbeats endpoint, only saving heartbeats
  to local offline cache when they were not accepted by the api.
- Upload multiple heartbeats to bulk endpoint for improved network performance.
  `wakatime#107 <https://github.com/wakatime/wakatime/issues/107>`_
- Fix bug causing 401 response when hidefilenames is enabled.
  `wakatime#106 <https://github.com/wakatime/wakatime/issues/106>`_
- Detect project and branch names from git submodules.
  `wakatime#105 <https://github.com/wakatime/wakatime/issues/105>`_
- Use WAKATIME_HOME env variable for offline and session caching.
  `wakatime#102 <https://github.com/wakatime/wakatime/issues/102>`_
- Allow passing string arguments wrapped in extra quotes for plugins which
  cannot properly escape spaces in arguments.
- Upgrade pytz to v2017.2.
- Upgrade requests to v2.18.4.
- Upgrade tzlocal to v1.4.
- Improve Matlab language detection.
- Only treat proxy string as NTLM proxy after unable to connect with HTTPS and
  SOCKS proxy.
- Support running automated tests on Linux, OS X, and Windows.
- Ability to disable SSL cert verification.
  `#90 <https://github.com/wakatime/wakatime/issues/90>`_
- Disable line count stats for files larger than 2MB to improve performance.
- Print error saying Python needs upgrading when requests can't be imported.
- Config file not needed when passing api key via command line.
- Allow colons in [projectmap] config section.
  `#83 <https://github.com/wakatime/wakatime/issues/83>`_
- When unable to detect language and debug mode turned on, log any tracebacks.
- Increase priority of F# and TypeScript languages.
- Add six library to satisfy missing dependency from ntlm-auth.
- Ability to prioritize common languages over uncommon lanuages.
  `#81 <https://github.com/wakatime/wakatime/issues/81>`_
- Rename alternate_language to language in extra heartbeats json.
- Rename --alternate-language cli argument to --language.
- Existing --alternate-language cli argument now overwrites auto-detected
  language. Previously, was only used when unable to auto-detect language.
- Give TypeScript higher priority than TypoScript.
- Support for Python 3.6.
- Support NTLM proxy format like domain\\user:pass.
  `#23 <https://github.com/wakatime/wakatime/issues/23>`_
- Upgrade pytz to v2016.10.
- Upgrade requests to v2.13.0.
- Upgrade pysocks to v1.6.6.
- Upgrade pygments library to v2.2.0 for improved language detection.
- Allow boolean or list of regex patterns for hidefilenames config setting.
- New WAKATIME_HOME env variable for setting path to config and log files.
  `#67 <https://github.com/wakatime/wakatime/issues/67>`_
- Improve debug warning message from unsupported dependency parsers.
  `#65 <https://github.com/wakatime/wakatime/issues/65>`_
- Exit with status code 104 when api key is missing or invalid. Exit with
  status code 103 when config file missing or invalid.
- Force file path to use system path separator.
- Handle exception from Python system library read permission problem.
- Prevent encoding errors when logging files with special characters.
- Upgrade pytz to v2016.6.1.
- Upgrade requests to v2.11.1.
- Upgrade simplejson to v3.8.2.
- Upgrade tzlocal to v1.2.2.


1.0.3 (2016-07-06)
++++++++++++++++++

- Upgrade wakatime-cli to v6.0.7.
- Handle unknown exceptions from requests library by deleting cached session
  object because it could be from a previous conflicting version.
- New hostname setting in config file to set machine hostname. Hostname
  argument takes priority over hostname from config file.
- Prevent logging unrelated exception when logging tracebacks.


1.0.2 (2016-07-01)
++++++++++++++++++

- Upgrade wakatime-cli to v6.0.6.
- Prevent tracking git branch with detached head.
- Support for SOCKS proxies.
- Prevent popup on Mac when xcode-tools is not installed.
- Increase default network timeout to 60 seconds when sending heartbeats to the api.
- Support regex patterns in projectmap config section for renaming projects.


1.0.1 (2016-03-18)
++++++++++++++++++

- Fix api key menu item.
- Detect project name from currently opened site.
- Upgrade wakatime-cli to v4.1.13.
- Encode TimeZone and hostname as utf-8 before adding to headers.


1.0.0 (2016-02-21)
++++++++++++++++++

- Birth.
