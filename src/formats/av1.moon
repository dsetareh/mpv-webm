class AV1 extends Format
	new: =>
		@displayName = "AV1"
		@supportsTwopass = true
		@videoCodec = "h264_nvenc"
		@audioCodec = "aac"
		@outputExtension = "webm"
		@acceptsBitrate = true

	getFlags: =>
		{
			"--ovcopts-add=threads=#{options.threads}",
			"--ovcopts-add=bf=0",
			-- rest is stuff to make the encode better (hopefully)
			"--ovcopts-add=preset=p1",
			"--ovcopts-add=rc=constqp",
			-- "--ovcopts-add=refs=2",
			"--ovcopts-add=tune=hq",
			-- fix crf for nvenc
			"--ovcopts-add=cq=#{options.crf}"
		}

formats["av1"] = AV1!
