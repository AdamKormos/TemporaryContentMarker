# Temporary Content Marker
A Godot plugin to help you remember temporarily added features before shipping.

Has it ever happened to you that you shipped a build with a feature you previously disabled for testing purposes, making it not work in the live game? Or the opposite, that you accidentally included something you didn't want to?

We've all been there. I wrote this pretty simple plugin to make development easier for myself, and I thought I might as well share it with everyone else!

# Instructions
1. Download the plugin from the Godot Asset Library or the zip file of this repo by clicking on "Code", and the "Local" menu. You should see a "Download ZIP" option.
2. If you downloaded manually, place the addons/temp_content_marker file into your project directory, ideally into a folder called "addons".
3. Go to Godot's Plugins tab (Project -> Project Settings -> Plugins) and tick "Enable" by the plugin.
4. You're good to go! Don't forget to read the documentation and add directories the code should ignore. You can modify the designation word and expand the list of ignorable directories at the top of the [TempContentMarker.gd](https://github.com/AdamKormos/TemporaryContentMarker/blob/main/addons/temp_content_marker/TempContentMarker.gd) script.

IMPORTANT: You can get rid of every file in this plugin except the TempContentMarker.gd script and "plugin.cfg". The rest of the files are just for demonstration of how the system works.

# Contact
If you have any questions/concerns or just wanna say hi, you can message me on [Twitter](https://twitter.com/olcgreen) or add me on Discord (Green#8661)

# Demonstration
![image](https://user-images.githubusercontent.com/49873113/221020007-40bff3c3-2575-4e21-bf97-34297b058041.png)

*The main plugin file (TempContentMarker.gd) allows you to specify the keyword to look for, when searching marked features. You can also assign ignored directories, like folders with art assets.*

![image](https://user-images.githubusercontent.com/49873113/221020063-8d7ed4f3-012a-4fd4-9953-a3192be30737.png)

*Using the plugin in practice to state this functionality is just for testing.*

![image](https://user-images.githubusercontent.com/49873113/221020102-72ca41ce-e468-4b9c-97bf-3dece2fd2793.png)

*Godot warns you about this line when trying to exit the editor.*
