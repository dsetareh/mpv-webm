class AV1 extends Format
	new: =>
		@displayName = "AV1 (NVENC)"
		@supportsTwopass = true
		@videoCodec = "av1_nvenc"
		@audioCodec = "aac"
		@outputExtension = "mp4"
		@acceptsBitrate = true

	getFlags: =>
		{
			"--ovcopts-add=preset=slow",
			"--ovcopts-add=rc=vbr",
			"--ovcopts-add=tune=hq",
			"--ovcopts-add=multipass=fullres",
			"--ovcopts-add=spatial-aq=1",
			"--ovcopts-add=temporal-aq=1",
			"--ovcopts-add=aq-strength=8",
			"--ovcopts-add=bf=3",
			"--ovcopts-add=b_ref_mode=middle",
			"--ovcopts-add=rc-lookahead=32",
			"--ovcopts-add=cq=#{options.crf}"
		}

formats["av1"] = AV1!
