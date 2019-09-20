package android

// Global config used by Candy soong additions
var CandyConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.candy.hardware",
	},
}
