tool
extends EditorPlugin

# Modify this as you wish. This is the text you should use in any case you want 
# to mark your comments/functionality as temporary, and you'll be able to see
# a list of these files + lines before you exit Godot. This tool helps you keep
# track of what you've temporarily modified and prevents you from accidentally
# shipping these modifications in builds.
# To disable the functionality, just set this plugin to Disabled in the Plugins tab.
const markerText : String = "no-checkin"

# You can expand this list with absolute directory paths to optimize look-up speed. In most projects,
# there is a separate, ginormous folder with all the graphics/sfx, you get the idea. Directories as
# such shouldn't be considered searching through for a script file. Even though this is an editor script,
# in the case of huge projects, it may take Godot a noticeable amount of time to process a huge 
# directory filled with hundreds/thousands of files.
# e.g var ignoredDirectoryPaths := ["res://Assets"]
var ignoredDirectoryPaths := ["res://addons/temp_content_marker/Assets"]


func _notification(what):
	if(Engine.editor_hint && what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		linesPerFilePath.clear()
		var paths : Array = run_temporary_mark_search()
		if(!paths.empty()):
			printerr(" --------------------------------------------------------------------------------------------------")
			printerr("| WAIT! You've got marked files with temporarily added things (" + str(paths.size()) + "):")
			for i in range(paths.size()): # List every marked file
				var markerIndices : String = ""
				for index in linesPerFilePath[paths[i]]:
					markerIndices += str(index) + ", " # List every marked line in the file
				markerIndices = markerIndices.substr(0, markerIndices.length() - 2) # Kind of a hack to skip the last marked line index's ", " addition from the line above
				printerr("| " + str(i + 1) + ". " + paths[i] + ": line " + markerIndices)
			printerr(" --------------------------------------------------------------------------------------------------")
		else:
			prints("[TemporaryCommentWarner] No temporary marks in any scripts. Good to go.")


var linesPerFilePath : Dictionary = {} # The collection of marked lines per script file.
func run_temporary_mark_search() -> Array:
	var markedFilePaths = []
	var dir = Directory.new()
	dir.open("res://")
	dir.list_dir_begin(true, false)
	traverse_directory(dir, markedFilePaths)
	return markedFilePaths


# Credit for the boilerplate: https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder
func traverse_directory(dir: Directory, markedFilePaths: Array):
	# We ignore the designated directories
	if(ignoredDirectoryPaths.has(dir.get_current_dir())): 
		return
	
	var file_name = dir.get_next() # Get the directory's next file name.
	
	# Loop through every file in the directory
	while (file_name != ""):
		# Appending a slash to res:// would make it have 3 sequential slashes, which messes up formatting
		# and comparison to this script's path, if it's directly in the root (meaning, this script would 
		# also get marked, since the path comparison would be res://TempContentMarker <-> res:///TempContentMarker)
		# But so, we append the file name to the current directory to receive the absolute path of the file.
		var path : String = dir.get_current_dir() + ('/' if dir.get_current_dir() != "res://" else '') + file_name
		# If the currently investigated file is this script, we don't operate
		if(get_script().resource_path == path):
			file_name = dir.get_next()
			continue
		
		# If the directory's current file is a directory, we recursively traverse it, given it's
		# not supposed to be ignored.
		if(dir.current_is_dir()):
			var subDir = Directory.new()
			subDir.open(path)
			subDir.list_dir_begin(true, false)
			traverse_directory(subDir, markedFilePaths)
		elif(path.get_extension() == "gd"): # The current file is a gd script:
			var scriptFile := File.new()
			scriptFile.open(path, File.READ)
			
			# We take the file's content and split it line by line so that we can
			# indicate which lines have temp comment marks. This could be done with
			# a simple find, but that's out of question if there are multiple marks.
			var content : String = scriptFile.get_as_text()
			var contentAsLines : Array = content.split('\n')
			var foundAtLeastOneMarkedLine : bool = false
			for i in range(contentAsLines.size()):
				# We look for the marker in every line.
				var markerIndex : int = contentAsLines[i].find(markerText)
				if(markerIndex != -1):
					# If a marker is found, we fill the dictionary that keeps track of each file's
					# marked line indices.
					if(!linesPerFilePath.has(path)): 
						linesPerFilePath[path] = [i + 1]
					else: 
						linesPerFilePath[path].append(i + 1)
					foundAtLeastOneMarkedLine = true
			
			# If at least one marked line has been recorded, we add this file
			if(foundAtLeastOneMarkedLine): 
				markedFilePaths.append(path)
			scriptFile.close()
		file_name = dir.get_next() # Get next file, continue the loop if possible
	dir.list_dir_end() # Close the directory
