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
			"--ovcopts-add=bf=0",
			"--ovcopts-add=preset=p7",
			"--ovcopts-add=rc=vbr",
			"--ovcopts-add=tune=hq",
			"--ovcopts-add=multipass=qres",
			"--ovcopts-add=spatial-aq=1",
			"--ovcopts-add=aq-strength=12",
			"--ovcopts-add=nonref_p=1",
			"--ovcopts-add=b_ref_mode=middle",
			"--ovcopts-add=strict_gop=1",
			"--ovcopts-add=rc-lookahead=32",
			"--ovcopts-add=cq=#{options.crf}"
		}

formats["av1"] = AV1!
