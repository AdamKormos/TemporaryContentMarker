# Temporary Content Marker
A Godot plugin to help you remember temporarily added features before shipping.

Has it ever happened to you that you shipped a build with a feature you previously disabled for testing purposes? Or the opposite, that you accidentally included something you didn't want to?
We've all been there. I wrote this pretty simple plugin to make development easier for myself, so I might as well share it with everyone!

# Instructions
1. Download the plugin from the Godot Asset Library or the zip file of this repo by clicking on "Code", and the "Local" menu. You should see a "Download ZIP" option.
2. If you downloaded manually, place the addons/temp_content_marker file into your project directory, ideally into a folder called "addons".
3. Go to Godot's Plugins tab (Project -> Project Settings -> Plugins) and tick "Enable" by the plugin.
4. You're good to go! Don't forget to read the documentation and add directories the code should ignore. You can modify the designation word and expand the list of ignorable directories at the top of the [TempContentMarker.gd](https://github.com/AdamKormos/TemporaryContentMarker/blob/main/addons/temp_content_marker/TempContentMarker.gd) script.

IMPORTANT: You can get rid of every file in this plugin except this script and "plugin.cfg". The rest of the files are just for demonstration.

# Contact
If you have any questions/concerns or just wanna say hi, you can hit me up at [Twitter](https://twitter.com/olcgreen) or add me on Discord (Green#8661)
