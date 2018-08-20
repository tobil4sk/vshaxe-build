package vshaxeBuild.project;

typedef Named = {
	final name:String;
}

typedef Project = {
	/** name of a target in defaults.json to base all targets in this config on **/
	@:optional final inherit:String;

	/** name of a target to generate special task.json tasks for (install-all, generate-complete-hxml, generate-vscode-tasks) **/
	@:optional final mainTarget:String;
	@:optional final haxelibs:ArrayHandle<Haxelib>;
	final targets:ArrayHandle<Target>;
}

/** simn is gonna love this naming... **/
typedef PlacedProject = {
	> Project,
	final directory:String;
	var subProjects:ArrayHandle<PlacedProject>;
}

typedef Haxelib = {
	> Named,
	final installArgs:ArrayHandle<String>;

	/** whether to look for a vshaxe-build.json in the install location of this lib **/
	@:optional var includeProjectFile:Bool;
}

typedef Target = {
	> Named,
	> TargetArguments,

	/** Whether this target is just a collection of other targets **/
	@:optional final composite:Bool;

	/** name of a target in defaults.json to base this config on **/
	@:optional final inherit:String;

	/** arguments that only apply in debug mode **/
	@:optional @:default({}) final debug:TargetArguments;

	/** arguments that only apply for display **/
	@:optional @:default({}) final display:TargetArguments;
}

typedef TargetArguments = {
	@:optional final targetDependencies:ArrayHandle<String>;

	/** additional, non-haxelib install commands (npm install...) **/
	@:optional final installCommands:ArrayHandle<ArrayHandle<String>>;
	@:optional final beforeBuildCommands:ArrayHandle<ArrayHandle<String>>;
	@:optional final afterBuildCommands:ArrayHandle<ArrayHandle<String>>;
	@:optional @:default({}) final args:Hxml;
}

typedef Hxml = {
	@:optional var workingDirectory:String; // just for internal use right now
	@:optional final classPaths:ArrayHandle<String>;
	@:optional final defines:ArrayHandle<String>;
	@:optional final haxelibs:ArrayHandle<String>;
	@:optional final macros:ArrayHandle<String>;
	@:optional final debug:Bool;
	@:optional final output:Output;
	@:optional final deadCodeElimination:DeadCodeElimination;
	@:optional final noInline:Bool;
	@:optional final times:Bool;
	@:optional final main:String; // can only specify either main or package, but you could specify both here :/
	@:optional final packageName:String;
}

@:enum abstract DeadCodeElimination(String) to String {
	var Standard = "std";
	var Full = "full";
	var No = "no";
}

typedef Output = {
	final target:HaxeTarget;
	final path:String;
}

@:enum abstract HaxeTarget(String) to String {
	var Swf = "swf";
	var Js = "js";
	var Neko = "neko";
	var Php = "php";
	var Cpp = "cpp";
	var Cppia = "cppia";
	var As3 = "as3";
	var Java = "java";
	var Python = "python";
	var Hl = "hl";
	var Lua = "lua";
}

@:forward(iterator)
abstract ArrayHandle<T>(Array<T>) from Array<T> {
	public function get() {
		return if (this == null) [] else this.copy();
	}
}
